#!/bin/bash
cat > sales.csv <<'CSV'
date,customer,amount,type
2026-07-03,Acme,4000,invoice
2026-07-19,Beta,5000,invoice
2026-08-02,Gamma,1000,invoice
2026-08-15,Delta,2000,invoice
2026-09-01,Beta,-5000,refund
2026-09-12,Acme,4000,invoice
CSV
