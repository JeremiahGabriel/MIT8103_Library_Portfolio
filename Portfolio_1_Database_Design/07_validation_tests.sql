-- MIT8103 Advanced Database Systems
-- University Library Management System
-- Portfolio 1: Database Design
-- File: 07_validation_tests.sql
-- Purpose: Test database constraints safely.
-- Method: Catch expected errors and report results.
-- The tests should not leave test records in the database.

DO $validation$
DECLARE
    v_book_id BIGINT;
    v_loan_id BIGINT;
BEGIN

    -- ==========================================
    -- TEST 1: Duplicate student number
    -- Expected: UNIQUE constraint violation
    -- ==========================================

    BEGIN
        INSERT INTO Student
            (student_number, first_name, last_name, email)
        VALUES
            ('STU001', 'Validation', 'Test',
             'validation_unique_test@example.com');

        INSERT INTO Student
            (student_number, first_name, last_name, email)
        VALUES
            ('STU001', 'Duplicate', 'Student',
             'duplicate_student_test@example.com');

        -- Reached only if both inserts unexpectedly succeed.
        DELETE FROM Student
        WHERE email IN (
            'validation_unique_test@example.com',
            'duplicate_student_test@example.com'
        );

        RAISE NOTICE
            'FAIL: Duplicate student number was accepted.';

    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE
                'PASS: Duplicate student number was rejected.';
        WHEN OTHERS THEN
            RAISE NOTICE
                'ERROR in student number test: %', SQLERRM;
    END;


    -- ==========================================
    -- TEST 2: Duplicate student email
    -- Expected: UNIQUE constraint violation
    -- ==========================================

    BEGIN
        INSERT INTO Student
            (student_number, first_name, last_name, email)
        VALUES
            ('VALIDATION_EMAIL_001', 'Duplicate', 'Email',
             'ada.okafor@example.com');

        -- Reached only if the duplicate email is accepted.
        DELETE FROM Student
        WHERE student_number = 'VALIDATION_EMAIL_001';

        RAISE NOTICE
            'FAIL: Duplicate student email was accepted.';

    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE
                'PASS: Duplicate student email was rejected.';
        WHEN OTHERS THEN
            RAISE NOTICE
                'ERROR in student email test: %', SQLERRM;
    END;


    -- ==========================================
    -- TEST 3: Invalid book-copy status
    -- Expected: CHECK constraint violation
    -- ==========================================

    SELECT book_id
    INTO v_book_id
    FROM Book
    ORDER BY book_id
    LIMIT 1;

    IF v_book_id IS NULL THEN
        RAISE NOTICE
            'SKIP: No book exists for the book-copy test.';
    ELSE
        BEGIN
            INSERT INTO BookCopy
                (book_id, barcode, copy_status)
            VALUES
                (v_book_id, 'VALIDATION-BARCODE-001',
                 'INVALID_STATUS');

            -- Reached only if the invalid status is accepted.
            DELETE FROM BookCopy
            WHERE barcode = 'VALIDATION-BARCODE-001';

            RAISE NOTICE
                'FAIL: Invalid book-copy status was accepted.';

        EXCEPTION
            WHEN check_violation THEN
                RAISE NOTICE
                    'PASS: Invalid book-copy status was rejected.';
            WHEN OTHERS THEN
                RAISE NOTICE
                    'ERROR in book-copy status test: %', SQLERRM;
        END;
    END IF;

    -- ==========================================
    -- TEST 4: Negative fine amount
    -- Expected: CHECK constraint violation
    -- ==========================================

    SELECT fine_id
    INTO v_loan_id
    FROM Fine
    ORDER BY fine_id
    LIMIT 1;

    IF v_loan_id IS NULL THEN
        RAISE NOTICE
            'SKIP: No fine record is available.';
    ELSE
        BEGIN
            UPDATE Fine
            SET amount = -100.00
            WHERE fine_id = v_loan_id;

            RAISE NOTICE
                'FAIL: Negative fine amount was accepted.';

        EXCEPTION
            WHEN check_violation THEN
                RAISE NOTICE
                    'PASS: Negative fine amount was rejected.';
            WHEN OTHERS THEN
                RAISE NOTICE
                    'ERROR in fine amount test: %', SQLERRM;
        END;
    END IF;

    -- ==========================================
    -- TEST 5: Invalid foreign-key reference
    -- Expected: FOREIGN KEY violation
    -- ==========================================

    BEGIN
        INSERT INTO Fine
            (loan_id, amount, amount_paid, fine_status)
        VALUES
            (-999999999, 0.00, 0.00, 'UNPAID');

        -- Reached only if the invalid reference is accepted.
        DELETE FROM Fine
        WHERE loan_id = -999999999;

        RAISE NOTICE
            'FAIL: Invalid loan reference was accepted.';

    EXCEPTION
        WHEN foreign_key_violation THEN
            RAISE NOTICE
                'PASS: Invalid loan reference was rejected.';
        WHEN OTHERS THEN
            RAISE NOTICE
                'ERROR in foreign-key test: %', SQLERRM;
    END;

END;
$validation$;