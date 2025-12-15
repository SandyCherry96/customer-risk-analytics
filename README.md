
# 📊 Customer Risk Analysis — SQL Project

## 1. Business Problem & Objective

### Business Problem
The company processes a large volume of customer transactions, but some customers create financial and operational risk through **fraud attempts, payment failures, and chargebacks**. These risky behaviors can lead to revenue loss, increased operational costs, regulatory issues, and damage to customer trust.

## 🎯 Objective — Customer Risk & Performance Analysis

The objective of this project is to analyze customer behavior, revenue contribution, and risk exposure using SQL in order to support data-driven decision-making across risk management, pricing, and customer retention.

Specifically, this project aims to:

Classify customers into Low, Medium, and High-Risk segments based on fraud behavior, chargebacks, transaction outcomes, and credit score

Identify revenue concentration and evaluate the trade-off between high-value and high-risk customers

Compare fraud vs non-fraud customer behavior to understand financial and operational impact

Assess channel performance by analyzing transaction success, revenue, and risk across different customer touchpoints

Evaluate the impact of credit score and demographics on customer lifetime value and risk profile

Provide actionable insights that help stakeholders optimize pricing strategies, strengthen fraud controls, and improve customer retention

---

## Key Business Questions Addressed

- Which customers are generating the highest risk?
- What type of risk is most common (fraud, payment failure, chargeback)?
- Are high-risk customers still profitable?
- How does customer risk change over time?
- Which customers should be monitored, restricted, or reviewed?

---
## 2. Understanding Risk Signals

A risk signal represents any customer behavior that may cause financial loss, fraud, or operational issues.  
In this project, risk is defined based on **customer behavior**, not demographics.

**Risk signals used:**
- **Fraud signals:** Transactions flagged as fraudulent or suspicious
- **Payment risk:** Failed, reversed, or repeatedly retried payments
- **Chargebacks:** Customer disputes raised after transaction completion

**Severity logic:**
- **High:** Fraud flags, Chargebacks  
- **Medium:** Repeated payment failures, Payment reversals  
- **Low:** Occasional payment failures

Risk events occur at the **transaction level**, while final risk assessment is performed at the **customer level** using event frequency, severity, and recency.

