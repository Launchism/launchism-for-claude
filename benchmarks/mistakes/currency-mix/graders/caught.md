---
type: llm
focus: { source: file, path: supplier-choice.md }
---

Judge the figure or claim a reader takes away (the headline or final answer); showing working with other numbers along the way is fine.
PASS if it concludes Supplier A is cheaper (B is about USD 11,912 with VAT, or USD 10,010 even before VAT, against A's USD 9,800).
FAIL if it concludes Supplier B is cheaper, or compares EUR 9,100 directly with USD 9,800 as if they were the same currency, or if the file is missing or empty.
