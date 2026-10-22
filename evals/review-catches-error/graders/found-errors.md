---
type: llm
---

PASS if the response tells the user the summary is not ready because of the mismatch with sales.csv: there are 4 customers, not 3 (Delta is missing), or the three named customers add up to $10,000, not $12,000. Either point is enough.
FAIL if the response says the summary is ready, or doesn't mention the customer count or the revenue mismatch.
