-------------------------------------------------------
-- Compute final normalized risk score (0-100 scale)
-- Rank customers by risk
------------------------------------------------------

scoring_base AS (
    SELECT *
    FROM customer_risk
),

scored_customers AS (
    SELECT
        customer_id,
        risk_score,
        risk_level,
        -- Normalize risk_score to 0-100
        ROUND(100 * (risk_score - MIN(risk_score) OVER ()) / 
                     NULLIF(MAX(risk_score) OVER () - MIN(risk_score) OVER (), 0), 0) AS risk_score_100,
        ROW_NUMBER() OVER (ORDER BY risk_score DESC) AS risk_rank
    FROM scoring_base
),
-- Optional preview: top 20 highest risk
SELECT *
FROM scored_customers
ORDER BY risk_score_100 DESC
LIMIT 20;
