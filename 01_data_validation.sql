/* ---------------------------------------------------------
   A. DATA VALIDATION CHECKS
   --------------------------------------------------------- */

-- 1. Record Count Verification
SELECT 'customers' AS table_name, COUNT(*) AS record_count FROM customers
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'fraud_flags', COUNT(*) FROM fraud_flags
UNION ALL
SELECT 'chargebacks', COUNT(*) FROM chargebacks;

-- 2. Primary Key Uniqueness Checks
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT payment_id, COUNT(*) AS duplicate_count
FROM payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- 3. Foreign Key Integrity (Orphan Records)
SELECT t.transaction_id
FROM transactions t
LEFT JOIN customers c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT p.payment_id
FROM payments p
LEFT JOIN transactions t
    ON p.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;

SELECT cb.chargeback_id
FROM chargebacks cb
LEFT JOIN transactions t
    ON cb.transaction_id = t.transaction_id
WHERE t.transaction_id IS NULL;

-- 4. Null Value Checks (Critical Columns)
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_ids,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS null_transaction_dates,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_transaction_amounts
FROM transactions;

-- 5. Data Type & Value Validation
SELECT *
FROM transactions
WHERE amount <= 0;

SELECT *
FROM chargebacks
WHERE chargeback_amount <= 0;

-- 6. Logical Consistency Check
-- Chargeback amount should not exceed transaction amount
SELECT
    cb.chargeback_id,
    cb.transaction_id,
    cb.chargeback_amount,
    t.amount AS transaction_amount
FROM chargebacks cb
JOIN transactions t
    ON cb.transaction_id = t.transaction_id
WHERE cb.chargeback_amount > t.amount;

/* ---------------------------------------------------------
   B. INITIAL DATA EXPLORATION
   --------------------------------------------------------- */

-- 7. Transactions per Customer Distribution
SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_value
FROM transactions
GROUP BY customer_id
ORDER BY total_transactions DESC;

-- 8. Failed Payment Frequency per Customer
SELECT
    t.customer_id,
    COUNT(*) AS failed_payments
FROM payments p
JOIN transactions t
    ON p.transaction_id = t.transaction_id
WHERE p.payment_status = 'FAILED'
GROUP BY t.customer_id
ORDER BY failed_payments DESC;

-- 9. Fraud Occurrence Rate
SELECT
    COUNT(DISTINCT f.transaction_id) AS fraud_transactions,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    ROUND(
        COUNT(DISTINCT f.transaction_id) * 100.0 /
        COUNT(DISTINCT t.transaction_id),
        2
    ) AS fraud_rate_percentage
FROM transactions t
LEFT JOIN fraud_flags f
    ON t.transaction_id = f.transaction_id;

-- 10. Chargeback Rate & Financial Impact
SELECT
    COUNT(DISTINCT transaction_id) AS chargeback_transactions,
    SUM(chargeback_amount) AS total_chargeback_amount
FROM chargebacks;

-- 11. Customer-Level Risk Signals Summary
SELECT
    t.customer_id,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    COUNT(DISTINCT f.transaction_id) AS fraud_count,
    COUNT(DISTINCT cb.transaction_id) AS chargeback_count,
    COUNT(DISTINCT p.payment_id)
        FILTER (WHERE p.payment_status = 'FAILED') AS failed_payments
FROM transactions t
LEFT JOIN fraud_flags f
    ON t.transaction_id = f.transaction_id
LEFT JOIN chargebacks cb
    ON t.transaction_id = cb.transaction_id
LEFT JOIN payments p
    ON t.transaction_id = p.transaction_id
GROUP BY t.customer_id
ORDER BY chargeback_count DESC, fraud_count DESC;

-- 12. Outlier Detection (High-Value Customers)
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY customer_id
HAVING SUM(amount) >
       (SELECT AVG(amount) * 5 FROM transactions)
ORDER BY total_amount DESC;

