# 📊 Customer Risk & Performance Analysis — SQL Project
## 📌 Project Overview

This project builds a customer-level risk and performance framework using SQL to analyze transactional behavior, revenue contribution, and risk exposure.
The goal is to help businesses identify high-risk customers, evaluate the revenue vs risk trade-off, and support data-driven decisions across risk management, pricing, and customer retention.

The project simulates a real-world risk analytics workflow, where risk signals such as fraud, payment failures, and chargebacks are scattered across multiple operational tables and must be consolidated into actionable insights.

## 🎯 Business Objective

The primary objective of this project is to identify and segment customers based on risk and performance by combining multiple behavioral risk signals and revenue metrics using SQL.

### Key Goals:

Classify customers into Low, Medium, and High Risk segments

Evaluate the profitability of high-risk vs low-risk customers

Compare fraud vs non-fraud customer behavior

Analyze risk exposure across different transaction channels

Provide actionable insights to improve fraud controls, pricing strategy, and customer retention

## 🧩 Dataset Overview & Schema Design

The analysis uses a relational transactional dataset with the following core tables:

customers — customer master data

transactions — purchase-level activity

payments — payment attempts and outcomes

fraud_flags — fraud indicators at transaction level

chargebacks — post-transaction disputes

### Schema Design Highlights:

customer_id is the primary key for customer-level analysis

transaction_id connects transactions to all risk events

Risk signals are captured at the transaction level and aggregated to the customer level

This normalized design ensures data integrity, traceability, and scalability.

## ⚠️ Understanding Risk Signals

Customer risk is derived from behavioral signals, not demographics alone.

Risk Indicators:

Fraud Risk — transactions flagged as fraudulent

Payment Risk — failed or reversed payments

Chargeback Risk — disputed transactions causing revenue loss

Risk Severity:

High Severity: Fraud flags, chargebacks

Medium Severity: Repeated payment failures

Low Severity: Occasional payment issues

Risk is evaluated based on frequency, severity, and recency of events.

## 🔍 Data Validation & Initial Exploration

Before analysis, extensive data validation was performed:

Primary and foreign key integrity checks

Duplicate and null value detection

Data type validation for dates and monetary fields

Logical consistency checks (e.g., chargeback amount ≤ transaction amount)

Initial exploration included:

Transaction distribution per customer

Fraud and chargeback rates

Payment failure patterns

Outlier detection

This ensured high-quality, reliable inputs for downstream analysis.
