---------------------------------------------------
--- 1. NORMALIZE METRICS 
--- Scale features to 0-1 for combined risk score
---------------------------------------------------

normalized_risk AS (
    SELECT
        *,
        chargeback_rate AS norml_chargeback_rate,
        failure_rate AS norml_failed_rate,
        CASE 
            WHEN recency_days IS NOT NULL
            THEN 1.0 / (1 + recency_days)
            ELSE 0
        END AS norml_recencydays,
        avg_transaction_amount / NULLIF(MAX(avg_transaction_amount) OVER (), 0)
            AS norml_amount

    FROM customer_agg
)

------------------------------------------
--- 2. CALCULATE COMBINED RISK SCORE
------------------------------------------
  
risk_score_calc AS (
    SELECT
        customer_id,
        total_transactions,
        total_chargebacks,
        chargeback_rate,
        failure_rate,
        recency_days,

    ROUND(
        (
            0.5 * COALESCE(norml_chargeback_rate, 0) +
            0.3 * COALESCE(norml_failed_rate, 0) +
            0.1 * COALESCE(norml_recencydays, 0) +
            0.1 * COALESCE(norml_amount, 0)
        )::numeric, 
        3
    ) AS risk_score

    FROM normalized_risk
)

-----------------------------------------------------------------
--- 3. ASSIGN RISK LEVEL - Using thresholds for low, medium, high
-----------------------------------------------------------------
  
customer_risk AS (
    SELECT
        *,
        CASE 
            WHEN risk_score >= 0.5 THEN 'HIGH'
            WHEN risk_score >= 0.2 THEN 'MEDIUM'
            ELSE 'LOW'
        END AS risk_level
    FROM risk_score_calc
)

-- Final table
CREATE TABLE customer_risk_metrics AS
SELECT *
FROM customer_risk;

SELECT *
FROM customer_risk_metrics
ORDER BY risk_score DESC
LIMIT 20;
