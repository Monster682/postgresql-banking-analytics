CREATE MATERIALIZED VIEW monthly_transaction_summary AS
SELECT
    DATE_TRUNC('month', txn_date) AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY 1;

