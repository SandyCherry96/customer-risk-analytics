-- 1. Count transactions per customer
SELECT
    customer_id,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY customer_id;

-- 2. Count successful and failure transactions
SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    COUNT(CASE WHEN status = 'success' THEN 1 END) AS successful_transactions,
    COUNT(CASE WHEN status <> 'success' THEN 1 END) AS failed_transactions,
    ROUND(
        COUNT(CASE WHEN status = 'success' THEN 1 END) * 1.0 / COUNT(*),
        2
    ) AS success_rate
FROM transactions
GROUP BY customer_id;


