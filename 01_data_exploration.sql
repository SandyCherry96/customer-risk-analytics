-- 1. Understand columns and data types
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'transactions';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'Customers';

-- 2. Row Count 
SELECT 
    COUNT(*) AS total_rows,
FROM transactions;

SELECT 
    COUNT(*) AS total_rows,
FROM Customers;


-- 3. Missing Values Check
SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS null_transaction_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE status IS NULL) AS null_status
FROM transactions;


SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE customer_name IS NULL) AS null_customer_name,
    COUNT(*) FILTER (WHERE signup_date IS NULL) AS null_signup_date
FROM customers;

-- 4. Duplicate Customer Check
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;







