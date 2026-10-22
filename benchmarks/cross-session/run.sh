#!/bin/sh
# Two-session memory test. Usage, from this folder: sh run.sh <with|without> <runs-per-task>
# Each task runs two separate `claude -p` conversations in the same folder: the first states a decision in
# passing during unrelated work; the second asks for work that depends on it. "with" enables the plugin,
# "without" disables it (Claude Code's own memory stays as you have it). Results go to $XSESSION_DIR
# (default ./runs). Grade afterwards with: python3 grade.py <XSESSION_DIR>
arm=$1; runs=${2:-3}
case "$arm" in with|without) ;; *) echo "usage: sh run.sh <with|without> [runs]" >&2; exit 2;; esac
here=$(cd "$(dirname "$0")" && pwd)
out=${XSESSION_DIR:-$here/runs}
if [ "$arm" = with ]; then claude plugin enable launchism@launchism >/dev/null 2>&1
else claude plugin disable launchism@launchism >/dev/null 2>&1; fi
python3 - "$here" "$out/$arm" "$runs" <<'PY'
import sys, os, subprocess
here, base, runs = sys.argv[1], sys.argv[2], int(sys.argv[3])
sys.path.insert(0, here)
from tasks import TASKS
for t in TASKS:
    for r in range(1, runs + 1):
        d = os.path.join(base, "%s-%d" % (t["name"], r)); os.makedirs(d, exist_ok=True)
        for p, c in t["files"].items():
            open(os.path.join(d, p), "w").write(c)
        logs = os.path.join(base, ".logs"); os.makedirs(logs, exist_ok=True)
        for i, prompt in ((1, t["s1"]), (2, t["s2"])):
            # Logs are kept OUTSIDE the task folder, so the second conversation can't read the first one's log.
            with open(os.path.join(logs, "%s-%d.s%d.log" % (t["name"], r, i)), "w") as log:
                subprocess.run(["claude", "-p", "--model", "sonnet", "--permission-mode", "acceptEdits", prompt],
                               cwd=d, stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT, timeout=900)
        print("done", t["name"], r, flush=True)
PY
