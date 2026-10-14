
-- MIT8103 Advanced Database Systems
-- Portfolio 1: Database Design and Modelling
-- Tests for fine-rate period protection.
-- The tests leave the original FineRate data unchanged.

-- Test 1: An overlapping period must be rejected.
DO $$
BEGIN
    BEGIN
        INSERT INTO FineRate (
            daily_rate,
            effective_from,
            effective_to
        )
        VALUES (
            150.00,
            DATE '2026-10-01',
            NULL
        );

        RAISE EXCEPTION
            'TEST_FAILED: overlapping period was accepted.';

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLERRM =
                'Fine-rate periods must not overlap existing periods.'
            THEN
                RAISE NOTICE
                    'PASS: overlapping fine-rate period was rejected.';
            ELSE
                RAISE;
            END IF;
    END;
END;
$$;

-- Test 2: A valid non-overlapping period is accepted,
-- then rolled back to preserve the original data.
BEGIN;

INSERT INTO FineRate (
    daily_rate,
    effective_from,
    effective_to
)
VALUES (
    80.00,
    DATE '2025-01-01',
    DATE '2025-12-31'
);

SELECT
    fine_rate_id,
    daily_rate,
    effective_from,
    effective_to
FROM FineRate
WHERE effective_from = DATE '2025-01-01';

ROLLBACK;

-- Final verification: the original record should remain.
SELECT
    fine_rate_id,
    daily_rate,
    effective_from,
    effective_to
FROM FineRate
ORDER BY effective_from;
