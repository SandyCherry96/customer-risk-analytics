insights_base AS (
    SELECT 
        cs.customer_id,
        cs.risk_segment,
        ca.total_transaction_amount,
        ca.total_chargebacks,
        ca.total_chargeback_amount,
        ca.total_transactions,
        ca.chargeback_rate
    FROM customer_segments cs
    JOIN customer_agg ca
        ON cs.customer_id = ca.customer_id
)

------------------------------------------------------
-- 10. FINAL INSIGHTS OUTPUT
------------------------------------------------------
SELECT
    risk_segment,
    COUNT(customer_id) AS total_customers,
    SUM(total_transactions) AS total_transactions,
    SUM(total_chargebacks) AS total_chargebacks,
    SUM(total_chargeback_amount) AS total_chargeback_amount,
    ROUND(AVG(chargeback_rate), 3) AS avg_chargeback_rate
FROM insights_base
GROUP BY risk_segment
ORDER BY total_chargebacks DESC;
