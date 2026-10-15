
-- MIT8103 Advanced Database Systems
-- Case Study: University Library Management System
-- Portfolio 2: Query Processing and Optimisation
-- Purpose: Repeat the baseline execution-plan test.

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    l.loan_id,
    l.student_id,
    l.copy_id,
    l.due_date
FROM public.loan AS l
WHERE l.return_date IS NULL
  AND l.due_date < CURRENT_DATE;
