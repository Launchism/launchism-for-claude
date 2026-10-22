# Changelog

## 0.1.0 (unreleased)
- Plugin skeleton.
- Standing rules, added at the start of every session (and after compact, clear, resume).
- Reporting skill: how Claude writes to you (status first, open count, options, recommendation, how to answer, evidence last).
- Fresh review skill, with two agents: a reviewer that tries to prove the work wrong, and a reader test for pages you act on.
- Memory skill: decisions kept word for word with dates, lessons, facts, and approaches tried and rejected, in ai-notes/. Ships three made-up example lessons, deleted once there are 5 real ones.
- Written-plan skill: plans with "done means" checks, handoffs a fresh chat can pick up, and a short walk for you to try the result.
- The standing rules now carry the minimum of each method and call each skill by name, because skills often didn't load by themselves in tests.
- The reviewer agent can only read, search and open web pages (it could run commands before).
- Test suite (evals/): 7 cases, each run with and without the plugin.
- End-of-reply check (hooks/review-gate.sh): when Claude created new files in a reply and the reviewer didn't run, Claude is sent back once to have the reviewer check them first.
- Named Launchism. README, MIT licence, and the two-session memory test (benchmarks/cross-session/).
