
-- MIT8103 Advanced Database Systems
-- Portfolio 1: Database Design
-- Prevent multiple active loans for one physical copy

CREATE UNIQUE INDEX uq_loan_one_active_per_copy
ON Loan (copy_id)
WHERE return_date IS NULL;
