#!/bin/sh
# review-gate.sh — Claude Code Stop hook that reminds Claude to run the
# plugin reviewer agent when the current turn created new files for the user
# and the reviewer did not run in the same turn.
#
# POSIX sh, no jq / python / node. Fail-open on every error (exit 0, silent).

set -u

IN=$(cat 2>/dev/null) || exit 0
[ -n "$IN" ] || exit 0

# Loop-breaker: stop_hook_active true in any whitespace form -> allow silently.
if printf '%s' "$IN" | grep -qE '"stop_hook_active"[[:space:]]*:[[:space:]]*true([^A-Za-z0-9_]|$)'; then
    exit 0
fi

TP=$(printf '%s' "$IN" | awk '
function extract_raw(s, key,    pat, p, i, n, c, out) {
    pat = "\"" key "\""
    p = index(s, pat)
    if (!p) return ""
    n = length(s)
    i = p + length(pat)
    while (i <= n) {
        c = substr(s, i, 1)
        if (c == " " || c == "\t" || c == ":") { i++; continue }
        break
    }
    if (substr(s, i, 1) != "\"") return ""
    i++
    out = ""
    while (i <= n) {
        c = substr(s, i, 1)
        if (c == "\\") { out = out c substr(s, i+1, 1); i += 2 }
        else if (c == "\"") { return out }
        else { out = out c; i++ }
    }
    return ""
}
{ v = extract_raw($0, "transcript_path"); if (v != "") { print v; exit } }
') 2>/dev/null || TP=""

[ -n "$TP" ] || exit 0
[ -f "$TP" ] && [ -r "$TP" ] || exit 0

# Subagent-transcript guard: Claude Code stores subagent transcripts under a
# directory named "subagents"; never block there.
PARENT_BASE=$(dirname "$TP" 2>/dev/null | awk -F/ '{print $NF}')
[ "$PARENT_BASE" = "subagents" ] && exit 0

tr -d '\r' < "$TP" | awk '
function extract_raw(s, key,    pat, p, i, n, c, out) {
    pat = "\"" key "\":\""
    p = index(s, pat)
    if (!p) return ""
    n = length(s)
    i = p + length(pat)
    out = ""
    while (i <= n) {
        c = substr(s, i, 1)
        if (c == "\\") { out = out c substr(s, i+1, 1); i += 2 }
        else if (c == "\"") { return out }
        else { out = out c; i++ }
    }
    return ""
}
function is_ai_notes(p,    q) {
    q = p
    if (substr(q, 1, 2) == "./") q = substr(q, 3)
    if (index(q, "/ai-notes/") > 0) return 1
    if (substr(q, 1, 9) == "ai-notes/") return 1
    return 0
}
function is_reviewer_name(v,    pos, pfx, tail) {
    if (v == "reviewer") return 1
    pos = index(v, ":reviewer")
    if (pos < 2) return 0
    tail = substr(v, pos)
    if (tail != ":reviewer") return 0
    pfx = substr(v, 1, pos - 1)
    if (pfx == "" || index(pfx, ":") > 0) return 0
    return 1
}
BEGIN {
    created_n = 0
    reviewer = 0
    sidechain = 0
}
{
    line = $0
    if (index(line, "\"isSidechain\":true") > 0) sidechain = 1
    if (index(line, "\"type\":\"api-request-blob\"") > 0) next
    if (index(line, "\"type\":\"queue-operation\"") > 0) next

    is_asst = (index(line, "\"type\":\"assistant\"") > 0)
    is_user = (!is_asst) && (index(line, "\"type\":\"user\"") > 0)

    if (is_asst) {
        if (index(line, "\"name\":\"Agent\"") > 0) {
            v = extract_raw(line, "subagent_type")
            if (is_reviewer_name(v)) reviewer = 1
        }
        next
    }
    if (is_user) {
        is_meta = (index(line, "\"isMeta\":true") > 0)
        is_tr = (index(line, "\"type\":\"tool_result\"") > 0)
        if (!is_meta && !is_tr) {
            # Genuine user message starts a new turn: reset per-turn state.
            created_n = 0
            delete created
            reviewer = 0
            next
        }
        if (is_tr) {
            if (index(line, "\"toolUseResult\":{\"type\":\"create\"") > 0) {
                fp = extract_raw(line, "filePath")
                if (fp != "" && !is_ai_notes(fp)) {
                    created_n++
                    created[created_n] = fp
                }
            }
        }
    }
}
END {
    if (sidechain) exit 0
    if (created_n == 0 || reviewer == 1) exit 0

    reason = "The reviewer did not run on this turn. Start the plugin reviewer agent on "
    cap = (created_n > 5) ? 5 : created_n
    for (i = 1; i <= cap; i++) {
        if (i > 1) reason = reason ", "
        reason = reason created[i]
    }
    if (created_n > 5) {
        over = created_n - 5
        reason = reason " and " over " more"
    }
    reason = reason ", fix what it finds, and then reply."

    printf "{\"decision\":\"block\",\"reason\":\"%s\"}\n", reason
}
' 2>/dev/null

exit 0
