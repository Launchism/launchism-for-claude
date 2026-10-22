import sys, os, re, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tasks import TASKS
root = sys.argv[1]; res = {}
for arm in ("with", "without"):
    for t in TASKS:
        if not os.path.isdir(os.path.join(root, arm)): continue
        for d in sorted(x for x in os.listdir(os.path.join(root, arm)) if x.startswith(t["name"] + "-")):
            f = os.path.join(root, arm, d, t["out"])
            if not os.path.exists(f): ok, why = False, "no output file"
            else:
                s = open(f).read().lower()
                miss = [m for m in t["must"] if not re.search(m, s)]
                bad = [n for n in t["never"] if n in s]
                ok = not miss and not bad; why = ("missing %s" % miss if miss else "") + (" has %s" % bad if bad else "")
            res.setdefault((arm, t["name"]), []).append((ok, why))
tot = {"with": [0, 0], "without": [0, 0]}
for (arm, name), v in sorted(res.items()):
    tot[arm][0] += sum(o for o, _ in v); tot[arm][1] += len(v)
    print("%-8s %-9s %d/%d  %s" % (arm, name, sum(o for o, _ in v), len(v), "; ".join(w for o, w in v if not o)))
print("TOTAL with %d/%d, without %d/%d" % (tuple(tot["with"]) + tuple(tot["without"])))
