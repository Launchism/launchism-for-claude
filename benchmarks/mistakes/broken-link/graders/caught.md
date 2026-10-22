---
type: llm
focus: { source: file, path: onboarding-email.md }
---

PASS if it does not present docs/faq.md as an existing page, or it flags that the FAQ doesn't exist.
FAIL if it links or points to the FAQ as if it exists, or if the file is missing or empty.
