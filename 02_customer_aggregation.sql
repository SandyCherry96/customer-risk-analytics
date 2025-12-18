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

------------------------------------------    
--- 3. CUSTOMER RISK FEATURE AGGREGATION
------------------------------------------

customer_agg AS (
    SELECT
        c.customer_id,
        c.signup_date,
        c.region,
        COALESCE(ts.total_transactions, 0) AS total_transactions,
        COALESCE(ts.total_transaction_amount, 0) AS total_transaction_amount,
        COALESCE(ts.avg_transaction_amount, 0) AS avg_transaction_amount,
        COALESCE(ts.first_transaction_date, NULL) AS first_transaction_date,
        COALESCE(ts.last_transaction_date, NULL) AS last_transaction_date,
        COALESCE(ts.failed_transactions, 0) AS failed_transactions,
        COALESCE(ts.successful_transactions, 0) AS successful_transactions,
        COALESCE(cb.total_chargebacks, 0) AS total_chargebacks,
        COALESCE(cb.total_chargeback_amount, 0) AS total_chargeback_amount,
        CASE 
            WHEN ts.total_transactions > 0 THEN ROUND(1.0 * COALESCE(cb.total_chargebacks, 0) / ts.total_transactions, 3)
            ELSE 0
        END AS chargeback_rate,
        CASE 
            WHEN ts.total_transactions > 0 THEN ROUND(1.0 * ts.failed_transactions / ts.total_transactions, 3)
            ELSE 0
        END AS failure_rate,
        -- Recency in days from last transaction to today
        CASE 
            WHEN ts.last_transaction_date IS NOT NULL THEN DATE_PART('day', CURRENT_DATE - ts.last_transaction_date)
            ELSE NULL
        END AS recency_days
    FROM customers c
    LEFT JOIN transaction_summary ts
        ON c.customer_id = ts.customer_id
    LEFT JOIN chargeback_summary cb
        ON c.customer_id = cb.customer_id
)
    
-----------------------------------------    
--- 4. FINAL CUSTOMER AGGREGATION OUTPUT
-----------------------------------------
SELECT *
FROM customer_agg
ORDER BY total_transactions DESC;





