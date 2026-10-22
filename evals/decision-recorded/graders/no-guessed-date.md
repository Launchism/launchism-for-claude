---
type: regex
pattern: "(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday),? (January|February|March|April|May|June|July|August|September|October|November|December) \\d"
match: not_contains
target: { source: file, path: ai-notes/decisions.md }
---
