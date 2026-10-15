
-- MIT8103 Advanced Database Systems
-- Case Study: University Library Management System
-- Portfolio 2: Query Optimisation
-- Purpose: Document and verify the candidate index.

-- 1. Create the candidate index if it does not already exist.
CREATE INDEX IF NOT EXISTS idx_bookcopy_book_id
ON public.bookcopy (book_id);

-- 2. Verify the index definition.
SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename = 'bookcopy'
  AND indexname = 'idx_bookcopy_book_id';

-- 3. Refresh statistics for the inventory query tables.
ANALYZE public.book;
ANALYZE public.bookcopy;
ANALYZE public.bookauthor;
ANALYZE public.author;
ANALYZE public.category;

-- =====================================================
-- EXPERIMENT FINDINGS
-- =====================================================
-- Candidate index:
-- idx_bookcopy_book_id on bookcopy(book_id).
--
-- The inventory query returned the same results after
-- the index was created.
--
-- PostgreSQL continued to use a sequential scan on
-- bookcopy with the current small dataset.
--
-- Overdue-loan index:
-- idx_loan_active_due_date on loan(due_date)
-- WHERE return_date IS NULL.
--
-- The overdue-loan query also used a sequential scan
-- on loan in both baseline and repeat tests.
--
-- Baseline execution time: 0.065 ms.
-- Repeat execution time: 0.116 ms.
--
-- The timings do not demonstrate an improvement.
-- More representative data and repeated controlled
-- tests are needed to assess performance at scale.