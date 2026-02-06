
-- CUSTOMERS
INSERT INTO customers (full_name, city, income, risk_profile)
VALUES
('Vaibhav Desai', 'Mumbai', 1200000, 'LOW'),
('Anita Verma', 'Pune', 800000, 'MEDIUM');


-- ACCOUNTS
INSERT INTO accounts (customer_id, account_type, balance, status, opened_at)
VALUES
(1, 'SAVINGS', 500000, 'ACTIVE', '2025-01-01'),
(2, 'CURRENT', 300000, 'ACTIVE', '2025-02-01');

-- TRANSACTIONS
INSERT INTO transactions (account_id, customer_id, txn_date, amount, txn_type, status)
VALUES
(1, 1, '2026-02-05', 20000, 'DEBIT', 'SUCCESS'),
(1, 1, '2026-02-06', 15000, 'DEBIT', 'SUCCESS'),
(1, 1, '2026-02-07', 18000, 'DEBIT', 'SUCCESS'),
(2, 2, '2026-02-07', 50000, 'CREDIT', 'SUCCESS');


-- LOANS
INSERT INTO loans (customer_id, principal, interest_rate, status, start_date)
VALUES
(1, 5000000, 8.5, 'ACTIVE', '2025-01-01');


-- LOAN PAYMENTS
INSERT INTO loan_payments (loan_id, payment_date, amount_paid, status)
VALUES
(1, '2026-01-01', 42000, 'PAID'),
(1, '2026-02-01', 0, 'MISSED'),
(1, '2026-03-01', 0, 'MISSED');
