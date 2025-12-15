CREATE VIEW risk_events AS

/* -------------------------
   FRAUD EVENTS
   ------------------------- */
SELECT
    t.customer_id,
    t.transaction_id,
    'FRAUD' AS risk_event_type,
    f.fraud_type AS risk_event_status,
    f.flagged_date AS risk_event_date,
    t.amount AS risk_amount,
    f.risk_score AS fraud_risk_score
FROM fraud_flags f
JOIN transactions t
    ON f.transaction_id = t.transaction_id

UNION ALL

/* -------------------------
   CHARGEBACK EVENTS
   ------------------------- */
SELECT
    t.customer_id,
    t.transaction_id,
    'CHARGEBACK' AS risk_event_type,
    cb.reason AS risk_event_status,
    cb.chargeback_date AS risk_event_date,
    cb.chargeback_amount AS risk_amount,
    NULL AS fraud_risk_score
FROM chargebacks cb
JOIN transactions t
    ON cb.transaction_id = t.transaction_id

UNION ALL

/* -------------------------
   FAILED PAYMENT EVENTS
   ------------------------- */
SELECT
    t.customer_id,
    t.transaction_id,
    'FAILED_PAYMENT' AS risk_event_type,
    p.payment_status AS risk_event_status,
    t.transaction_date AS risk_event_date,
    t.amount AS risk_amount,
    NULL AS fraud_risk_score
FROM payments p
JOIN transactions t
    ON p.transaction_id = t.transaction_id
WHERE p.payment_status = 'FAILED';
