-- MIT8103 Advanced Database Systems
-- Case Study: University Library Management System
-- Portfolio 2: Query Processing and Optimisation
-- Purpose: Baseline queries and execution-plan analysis
-- Database: university_library

-- =====================================================
-- QUERY 1: Library inventory by book title
-- Shows each title, category, authors and copy counts.
-- DISTINCT prevents author joins from inflating copy counts.
-- =====================================================

SELECT
    b.book_id,
    b.title,
    c.category_name,
    STRING_AGG(
        DISTINCT a.first_name || ' ' || a.last_name,
        ', ' ORDER BY a.first_name || ' ' || a.last_name
    ) AS authors,
    COUNT(DISTINCT bc.copy_id) AS total_copies,
    COUNT(DISTINCT bc.copy_id) FILTER (
        WHERE bc.copy_status = 'AVAILABLE'
    ) AS available_copies
FROM public.book AS b
JOIN public.category AS c
    ON c.category_id = b.category_id
LEFT JOIN public.bookauthor AS ba
    ON ba.book_id = b.book_id
LEFT JOIN public.author AS a
    ON a.author_id = ba.author_id
LEFT JOIN public.bookcopy AS bc
    ON bc.book_id = b.book_id
GROUP BY
    b.book_id,
    b.title,
    c.category_name
ORDER BY b.title;


-- =====================================================
-- QUERY 2: Active loans
-- Shows borrowers, titles, copy barcodes and due dates.
-- =====================================================

SELECT
    l.loan_id,
    s.student_number,
    s.first_name || ' ' || s.last_name AS student_name,
    b.title,
    bc.barcode,
    st.first_name || ' ' || st.last_name AS staff_name,
    l.loan_date,
    l.due_date
FROM public.loan AS l
JOIN public.student AS s
    ON s.student_id = l.student_id
JOIN public.bookcopy AS bc
    ON bc.copy_id = l.copy_id
JOIN public.book AS b
    ON b.book_id = bc.book_id
JOIN public.staff AS st
    ON st.staff_id = l.staff_id
WHERE l.return_date IS NULL
ORDER BY l.due_date;


-- =====================================================
-- QUERY 3: Overdue active loans
-- Calculates current overdue days and estimated fines.
-- This query does not update the Fine table.
-- =====================================================

SELECT
    l.loan_id,
    s.student_number,
    s.first_name || ' ' || s.last_name AS student_name,
    b.title,
    l.due_date,
    CURRENT_DATE - l.due_date AS days_overdue,
    fr.daily_rate,
    (CURRENT_DATE - l.due_date) * fr.daily_rate
        AS estimated_fine
FROM public.loan AS l
JOIN public.student AS s
    ON s.student_id = l.student_id
JOIN public.bookcopy AS bc
    ON bc.copy_id = l.copy_id
JOIN public.book AS b
    ON b.book_id = bc.book_id
JOIN public.finerate AS fr
    ON CURRENT_DATE >= fr.effective_from
   AND (
       fr.effective_to IS NULL
       OR CURRENT_DATE <= fr.effective_to
   )
WHERE l.return_date IS NULL
  AND l.due_date < CURRENT_DATE
ORDER BY l.due_date;


-- =====================================================
-- QUERY 4: Fine and payment details
-- Shows recorded fines, payments and outstanding balances.
-- These are stored amounts, not recalculated estimates.
-- =====================================================

SELECT
    f.fine_id,
    f.loan_id,
    s.student_number,
    s.first_name || ' ' || s.last_name AS student_name,
    b.title,
    f.amount AS recorded_fine,
    f.amount_paid,
    f.amount - f.amount_paid AS outstanding_balance,
    f.fine_status
FROM public.fine AS f
JOIN public.loan AS l
    ON l.loan_id = f.loan_id
JOIN public.student AS s
    ON s.student_id = l.student_id
JOIN public.bookcopy AS bc
    ON bc.copy_id = l.copy_id
JOIN public.book AS b
    ON b.book_id = bc.book_id
ORDER BY f.fine_id;


-- =====================================================
-- QUERY 5: Baseline execution plan for overdue loans
-- EXPLAIN ANALYZE executes the SELECT and reports actual
-- execution details. The SELECT does not change table data.
-- =====================================================

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    l.loan_id,
    l.student_id,
    l.copy_id,
    l.due_date
FROM public.loan AS l
WHERE l.return_date IS NULL
  AND l.due_date < CURRENT_DATE;