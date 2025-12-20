# Customer Risk Analysis

## Overview

This project analyzes **customer-level risk** using historical transaction data.
The objective is to identify customers who are more likely to cause
**financial loss or operational burden**, enabling businesses to
prioritize monitoring, controls, and interventions.

This is an **analytics-driven risk framework**, not a fraud detection or machine learning model.
The emphasis is on **clear SQL logic, explainability, and business relevance**.

---

## Problem Statement

In high-volume payment systems:
- Risk is unevenly distributed across customers
- A small subset often drives a disproportionate share of losses
- Blanket rules and manual reviews do not scale

**Key question:**
> How can we quantify customer risk using only historical transaction behavior?

---

## Unit of Analysis

- **Unit of risk:** Customer  
- All transaction-level signals are aggregated to the customer level

This mirrors real-world decision-making:
- Limits are applied per customer
- Reviews are conducted per customer
- Business actions are taken per customer

---

## Risk Framework

Customer risk is defined as the likelihood of causing
**future financial or operational impact**.

The framework is built using four core dimensions:

1. **Chargebacks**
   - Confirmed financial disputes
   - Direct indicator of realized loss

2. **Transaction Failures**
   - Declines and errors
   - Indicate friction and operational overhead

3. **Transaction Recency**
   - Recent activity reflects current exposure
   - Dormant customers pose lower immediate risk

4. **Transaction Amount**
   - High-value transactions increase downside risk
   - Risk is asymmetric rather than linear

No single metric defines risk in isolation.
Risk emerges from the **combination of behavioral signals**.

---

## Repository Structure


Customer_Risk_Analysis/
├── analysis/
│ ├── risk_definition.md
│ ├── metric_logic.md
├── sql/
│ ├── 01_data_understanding.sql
│ ├── 02_customer_aggregation.sql
│ ├── 03_risk_metric_calculation.sql
│ ├── 04_risk_scoring.sql
│ ├── 05_customer_segmentation.sql
│ └── 06_final_insights.sql
├── results/
│ ├── key_findings.md
│ └── business_recommendations.md



---

## SQL Workflow

The analysis follows a **step-by-step SQL pipeline**, designed to reflect
how risk analysis would be built in production.

### 1. Data Understanding (`01_data_understanding.sql`)
- Explore transaction volumes and time ranges
- Validate joins between transactions, customers, and chargebacks
- Identify missing values and anomalies

### 2. Customer Aggregation (`02_customer_aggregation.sql`)
- Aggregate transaction-level data to the customer level
- Compute base metrics such as:
  - Total transactions
  - Total transaction amount
  - Failed transaction count
  - Chargeback count

### 3. Risk Metric Calculation (`03_risk_metric_calculation.sql`)
- Derive core risk signals:
  - Chargeback rate
  - Failure rate
  - Transaction recency
  - High-value transaction indicators

### 4. Risk Scoring (`04_risk_scoring.sql`)
- Combine individual risk signals into a composite risk score
- Apply simple, explainable logic (rule-based or weighted)
- Avoid black-box modeling

### 5. Customer Segmentation (`05_customer_segmentation.sql`)
- Bucket customers into risk tiers (e.g., Low / Medium / High)
- Ensure segments are interpretable and actionable

### 6. Final Insights (`06_final_insights.sql`)
- Summarize risk distribution
- Identify concentration of risk
- Generate outputs used for business recommendations

---

## Key Insights (High Level)

- Risk is **highly concentrated** among a small percentage of customers
- Elevated failure rates often precede chargebacks
- Recent high-value activity amplifies exposure
- Transaction volume alone does not imply high risk

Detailed findings are available in `results/key_findings.md`.

---

## Business Value

This framework enables:
- Targeted monitoring instead of blanket rules
- Reduced operational overhead
- Faster identification of high-risk customers
- Clear communication between technical and business teams

---

## Assumptions & Limitations

- Based solely on historical transaction behavior
- No external or real-time signals included
- Correlation, not causation
- Prioritizes explainability over predictive power

See `analysis/assumptions_limitations.md` for full details.

---

## Future Enhancements

Potential extensions include:
- Time-decayed metrics
- Weighted or dynamic scoring
- Predictive models
- Integration with real-time transaction systems

---

## Why This Project Matters

This project demonstrates:
- Strong SQL-based analytical thinking
- Clear definition of **unit of risk**
- Business-first metric design
- Ability to build explainable, production-friendly analytics
