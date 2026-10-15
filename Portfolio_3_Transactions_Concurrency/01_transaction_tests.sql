
-- MIT8103 Advanced Database Systems
-- Portfolio 3: Transactions and Concurrency
-- Case Study: University Library Management System
--
-- Purpose:
-- 1. Demonstrate ROLLBACK.
-- 2. Demonstrate COMMIT.
-- 3. Document transaction isolation using two sessions.
-- 4. Demonstrate the unique index protecting active loans.
--
-- IMPORTANT:
-- The tests below document the practical exercises already performed.
-- Run the isolation test in two separate pgAdmin Query Tool sessions.
-- The duplicate-loan test is expected to fail with a unique violation.

-- ============================================================
-- TEST 1: ROLLBACK
-- Expected: COPY004 returns to AVAILABLE after ROLLBACK.
-- ============================================================

BEGIN;

UPDATE public.bookcopy
SET copy_status = 'ON_LOAN'
WHERE copy_id = 4
  AND copy_status = 'AVAILABLE';

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;

ROLLBACK;

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;


-- ============================================================
-- TEST 2: COMMIT
-- Expected: The change is saved, then the original status
-- is restored and committed.
-- ============================================================

BEGIN;

UPDATE public.bookcopy
SET copy_status = 'ON_LOAN'
WHERE copy_id = 4
  AND copy_status = 'AVAILABLE';

COMMIT;

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;

BEGIN;

UPDATE public.bookcopy
SET copy_status = 'AVAILABLE'
WHERE copy_id = 4
  AND copy_status = 'ON_LOAN';

COMMIT;

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;


-- ============================================================
-- TEST 3: TRANSACTION ISOLATION
-- Run the statements in the two sessions as described below.
-- ============================================================

-- SESSION A:
BEGIN;

UPDATE public.bookcopy
SET copy_status = 'ON_LOAN'
WHERE copy_id = 4
  AND copy_status = 'AVAILABLE';

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;

-- SESSION B, before Session A commits:
SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;

-- SESSION A:
COMMIT;

-- SESSION B, after Session A commits:
SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;

-- RESTORE THE ORIGINAL STATUS after completing the isolation test:
BEGIN;

UPDATE public.bookcopy
SET copy_status = 'AVAILABLE'
WHERE copy_id = 4
  AND copy_status = 'ON_LOAN';

COMMIT;

SELECT copy_id, barcode, copy_status
FROM public.bookcopy
WHERE copy_id = 4;


-- ============================================================
-- TEST 4: CONCURRENCY CONTROL
-- Expected: The INSERT fails because COPY003 already has
-- an active loan and the unique partial index prevents
-- a second active loan for the same copy.
--
-- Run this test separately. The expected error is intentional.
-- After the error, run ROLLBACK in the same session.
-- ============================================================

BEGIN;

INSERT INTO public.loan (
    copy_id,
    student_id,
    staff_id,
    loan_date,
    due_date,
    return_date
)
VALUES (
    3,
    1,
    1,
    CURRENT_DATE,
    CURRENT_DATE + 14,
    NULL
);

-- After the expected duplicate-key error, run:
-- ROLLBACK;


-- ============================================================
-- TEST 5: VERIFY THE EXISTING ACTIVE LOAN
-- Run after rolling back the failed INSERT.
-- Expected: Only the original active loan remains.
-- ============================================================

SELECT loan_id, copy_id, student_id, staff_id, return_date
FROM public.loan
WHERE copy_id = 3
  AND return_date IS NULL;
