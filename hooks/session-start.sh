#!/bin/sh
# Runs at the start of every session. Prints the standing rules, which Claude Code adds to the session.
# In a project that already uses ai-notes/ but has no lessons folder yet, copies in the example lessons.
root="${CLAUDE_PLUGIN_ROOT}"
project="${CLAUDE_PROJECT_DIR:-$PWD}"

[ -n "$root" ] && [ -f "$root/rules/standing-rules.md" ] || exit 0

cat "$root/rules/standing-rules.md"

examples="$root/skills/memory/examples"
if [ -d "$project/ai-notes" ] && [ ! -L "$project/ai-notes" ] && [ ! -e "$project/ai-notes/lessons" ]; then
  set -- "$examples"/*.md
  if [ -f "$1" ] && mkdir "$project/ai-notes/lessons" 2>/dev/null; then
    if cp "$@" "$project/ai-notes/lessons/" 2>/dev/null; then
      printf '\nThe example lessons were just copied into ai-notes/lessons/. Add them to ai-notes/INDEX.md.\n'
    else
      rm -f "$project/ai-notes/lessons/"*.md 2>/dev/null
      rmdir "$project/ai-notes/lessons" 2>/dev/null
    fi
  fi
fi
exit 0
