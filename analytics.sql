
-- CUSTOMER LIFETIME VALUE
SELECT 
    c.customer_id,
    c.full_name,
    SUM(t.amount) AS total_transaction_value
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
JOIN transactions t ON a.account_id = t.account_id
GROUP BY c.customer_id, c.full_name;


-- FRAUD DETECTION (HIGH VELOCITY)
SELECT 
    account_id,
    COUNT(*) AS txn_count,
    SUM(amount) AS total_amount
FROM transactions
WHERE status = 'SUCCESS'
GROUP BY account_id
HAVING COUNT(*) > 2 AND SUM(amount) > 40000;

-- LOAN DEFAULT / NPA RISK
SELECT 
    loan_id,
    COUNT(*) FILTER (WHERE status='MISSED') AS missed_payments,
    CASE
        WHEN COUNT(*) FILTER (WHERE status='MISSED') >= 2 THEN 'HIGH RISK'
        ELSE 'LOW RISK'
    END AS risk_level
FROM loan_payments
GROUP BY loan_id;


-- PARTITION PRUNING CHECK
EXPLAIN (ANALYZE, BUFFERS)
SELECT *
FROM transactions
WHERE account_id = 1
ORDER BY txn_date DESC;
