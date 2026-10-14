
-- MIT8103 Advanced Database Systems
-- Portfolio 1: Database Design and Modelling
-- Purpose: Prevent overlapping fine-rate effective periods.

CREATE OR REPLACE FUNCTION prevent_overlapping_fine_rate_periods()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM FineRate AS fr
        WHERE fr.fine_rate_id <> NEW.fine_rate_id
          AND (
              NEW.effective_to IS NULL
              OR fr.effective_from <= NEW.effective_to
          )
          AND (
              fr.effective_to IS NULL
              OR fr.effective_to >= NEW.effective_from
          )
    ) THEN
        RAISE EXCEPTION
            'Fine-rate periods must not overlap existing periods.';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_prevent_overlapping_fine_rate_periods
BEFORE INSERT OR UPDATE ON FineRate
FOR EACH ROW
EXECUTE FUNCTION prevent_overlapping_fine_rate_periods();
