
-- CLEAN RESET 
DROP TABLE IF EXISTS loan_payments CASCADE;
DROP TABLE IF EXISTS loans CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- CUSTOMERS
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    city VARCHAR(50),
    income NUMERIC(12,2),
    risk_profile VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ACCOUNTS
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    account_type VARCHAR(20),
    balance NUMERIC(14,2),
    status VARCHAR(20),
    opened_at DATE
);

-- TRANSACTIONS (PARTITIONED)
CREATE TABLE transactions (
    txn_id BIGSERIAL,
    account_id INT,
    customer_id INT,
    txn_date DATE,
    amount NUMERIC(12,2),
    txn_type VARCHAR(10),
    status VARCHAR(20)
) PARTITION BY RANGE (txn_date);

-- Monthly partitions (mentor-approved)
CREATE TABLE transactions_2026_01
PARTITION OF transactions
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE transactions_2026_02
PARTITION OF transactions
FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');

-- LOANS
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    principal NUMERIC(14,2),
    interest_rate NUMERIC(5,2),
    status VARCHAR(20),
    start_date DATE
);

-- LOAN PAYMENTS
CREATE TABLE loan_payments (
    payment_id SERIAL PRIMARY KEY,
    loan_id INT REFERENCES loans(loan_id),
    payment_date DATE,
    amount_paid NUMERIC(12,2),
    status VARCHAR(20)
);

-- INDEXES (ORDER & SEQUENCE MATTER)
-- Composite index (account → date)
CREATE INDEX idx_txn_acc_date
ON transactions (account_id, txn_date DESC);

-- Partial index (SUCCESS only)
CREATE INDEX idx_txn_success
ON transactions (account_id, txn_date)
WHERE status = 'SUCCESS';

-- Covering index (index-only scans)
CREATE INDEX idx_txn_covering
ON transactions (account_id, txn_date)
INCLUDE (amount, txn_type);
