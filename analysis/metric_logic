# Metric Logic

This document explains **how raw transaction data is converted into customer-level risk signals**.

---

## 1. Chargeback Rate

**Definition**
Percentage of a customer’s transactions that resulted in chargebacks.

**Logic**
- Count chargebacks per customer
- Divide by total transactions

**Why it matters**
Chargebacks represent confirmed disputes and direct financial loss.

---

## 2. Failure Rate

**Definition**
Percentage of transactions that failed (e.g., payment declined, timeout).

**Logic**
- Count failed transactions per customer
- Divide by total transactions

**Why it matters**
High failure rates increase operational overhead and often precede disputes.

---

## 3. Transaction Recency

**Definition**
Number of days since the customer’s most recent transaction.

**Logic**
- Find the latest transaction date per customer
- Calculate days since that date

**Why it matters**
Recent activity means current exposure.
Inactive customers are lower immediate risk.

---

## 4. Transaction Amount Signals

**Metrics**
- Total transaction amount
- Average transaction value
- High-value transaction frequency

**Why it matters**
Risk is asymmetric — large transactions create disproportionate downside.

---

## Aggregation Principle

All metrics are:
- Calculated at the transaction level
- Aggregated to the **customer level**
- Used together to form a holistic risk profile

No single metric defines risk on its own.
