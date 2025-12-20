# Customer Risk Definition

## What is Customer Risk?

In this project, **customer risk** is defined as the likelihood that a customer will cause
**financial loss or operational burden** to the business in the future.

This includes:
- Direct financial loss (e.g., chargebacks, refunds)
- Indirect costs (e.g., payment failures, manual reviews, support overhead)
- Exposure from high-value or recent activity

The goal is **not** to label customers as fraudulent, but to **prioritize monitoring and controls**
based on measurable behavior.

---

## Unit of Risk

The **unit of risk is the customer**, not individual transactions.

All transaction-level signals are aggregated to answer:
> “What does this customer look like in numbers?”

This aligns with real-world decision-making:
- Limits are set per customer
- Reviews happen per customer
- Business actions are taken per customer

---

## Components of Risk

Customer risk is modeled using four primary dimensions:

1. **Chargeback Behavior**
   - Indicates confirmed financial disputes
   - Strongest signal of realized loss

2. **Transaction Failures**
   - Indicates payment friction or abnormal behavior
   - Creates operational cost and potential future disputes

3. **Transaction Recency**
   - Recent activity represents current exposure
   - Dormant customers pose minimal immediate risk

4. **Transaction Amount / Value**
   - Higher amounts increase downside risk
   - Frequency of high-value transactions compounds exposure

---

## What This Is Not

- Not a fraud detection model
- Not a credit score
- Not a prediction of intent

This is a **risk prioritization framework** built using historical behavior.
