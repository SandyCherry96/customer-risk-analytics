----------------------------------------------------
--- Segment customers by risk_score_100
--- Assign categorical segments for business actions
----------------------------------------------------

segmentation_base AS (
    SELECT *
    FROM scored_customers
),

customer_segments AS (
    SELECT
        customer_id,
        risk_score_100,
        risk_level,
        CASE
            WHEN risk_score_100 >= 70 THEN 'HIGH_RISK'
            WHEN risk_score_100 >= 40 THEN 'MEDIUM_RISK'
            ELSE 'LOW_RISK'
        END AS risk_segment
    FROM segmentation_base
)
-- Optional: Distribution summary
SELECT risk_segment, COUNT(*) AS customer_count, ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM customer_segments
GROUP BY risk_segment
ORDER BY customer_count DESC;
