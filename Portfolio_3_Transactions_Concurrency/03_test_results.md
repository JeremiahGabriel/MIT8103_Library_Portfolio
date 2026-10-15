# Portfolio 3: Transaction Test Results

## Case Study: University Library Management System

### 1. Test Summary

I carried out the tests using PostgreSQL and pgAdmin 4 to check transaction commitment, rollback, isolation between sessions, and the prevention of duplicate active loans.

| Test | Expected result | Observed result | Status |
|---|---|---|---|
| ROLLBACK | Uncommitted change is cancelled | COPY004 returned to AVAILABLE | Passed |
| COMMIT | Change is saved | COPY004 changed to ON_LOAN and was later restored to AVAILABLE | Passed |
| Transaction isolation before commit | Session B does not see Session A's uncommitted change | Session A saw ON_LOAN, while Session B saw AVAILABLE | Passed |
| Transaction isolation after commit | Session B sees the committed change | Session B returned ON_LOAN | Passed |
| Duplicate active-loan control | A second active loan for the same copy is rejected | PostgreSQL returned SQL state 23505 for `uq_loan_one_active_per_copy` | Passed |
| Final verification | Original active loan remains unchanged | Loan ID 2 remained the only active loan for copy ID 3 | Passed |

### 2. Evidence Files

The screenshots showing the test results are stored in the `evidence` folder:

- `01_rollback_test.png`
- `02_commit_test.png`
- `03_isolation_before_commit.png`
- `04_isolation_after_commit.png`
- `05_concurrency_control.png`

### 3. Final Database State

After the tests, COPY004 was restored to `AVAILABLE`. The original active loan for COPY003 remained in the database, and the attempted duplicate loan was not inserted.

### 4. Overall Result

All tests produced the expected results. The results confirmed that `COMMIT` saves changes, `ROLLBACK` cancels uncommitted changes, and PostgreSQL's default `READ COMMITTED` isolation level controls what each session can see. The unique partial index also rejected the attempt to create a second active loan for the same book copy.