---------------------------------------
--- 1. CUSTOMER TRANSACTION AGGREGATION
---------------------------------------

WITH transaction_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_transactions,
        SUM(amount) AS total_transaction_amount,
        AVG(amount) AS avg_transaction_amount,
        MIN(transaction_date) AS first_transaction_date,
        MAX(transaction_date) AS last_transaction_date,
        COUNT(*) FILTER (WHERE status = 'FAILED') AS failed_transactions,
        COUNT(*) FILTER (WHERE status = 'SUCCESS') AS successful_transactions
    FROM transactions
    GROUP BY customer_id
),

-------------------------------------------
 --- 2. CHARGEBACK AGGREGATION
-------------------------------------------

chargeback_summary AS (
    SELECT
        t.customer_id,
        COUNT(cb.chargeback_id) AS total_chargebacks,
        SUM(cb.chargeback_amount) AS total_chargeback_amount
    FROM chargebacks cb
    JOIN transactions t
        ON cb.transaction_id = t.transaction_id
    GROUP BY t.customer_id
),

-------------------------------------    
--- 3. CUSTOMER RISK FEATURE AGGREGATION
------------------------------------







