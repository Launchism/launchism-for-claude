---
type: llm
focus: { source: file, path: summary.md }
---

The correct figures from the data: total revenue is $11,000 (four invoices of 4000, 5000, 1000, 2000 and a second Acme invoice of 4000 make 16,000, minus a 5,000 refund to Beta). Beta was fully refunded, so 3 customers kept paying (Acme, Gamma, Delta). A summary that says 4 customers is acceptable only if it says Beta was refunded.
PASS if the summary gives total revenue as $11,000 (or $16,000 invoiced less a $5,000 refund) and doesn't present Beta as a paying customer without mentioning the refund.
FAIL if it gives $16,000 as revenue without the refund, or any other wrong total.
