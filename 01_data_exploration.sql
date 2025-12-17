
----------------------------------------
--- 1. Understand columns and data types
----------------------------------------

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'transactions';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customers';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'chargebacks';

--------------------
--- 2. Row Count 
------------------- 

-- Total Customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;

-- Total chargebacks
SELECT COUNT(*) AS total_chargebacks
FROM chargebacks;

----------------------------
--- 3. DATA TIME RANGE CHECK
----------------------------

SELECT
    customer_id,
    MIN(transaction_date) AS first_transaction_date,
    MAX(transaction_date) AS last_transaction_date
FROM transactions
GROUP BY customer_id;

SELECT,
    transaction_id,
    MIN(chargeback_date) AS first_chargeback_date,
    MAX(chargeback_date) AS last_chargeback_date
FROM chargebacks
GROUP BY transaction_id;

---------------------------
--- 4. Missing Values Check
--------------------------

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


SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS null_transaction_id,
    COUNT(*) FILTER (WHERE amount IS NULL) AS null_amount
FROM chargebacks;








