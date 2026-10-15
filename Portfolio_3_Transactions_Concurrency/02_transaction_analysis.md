# Portfolio 3: Transactions and Concurrency

## Case Study: University Library Management System

### 1. Introduction

This portfolio covers transaction management and concurrency control in the University Library Management System. Using PostgreSQL, the tests examine how `COMMIT` and `ROLLBACK` work, how transactions behave across separate sessions, and how the database prevents duplicate active loans for the same book copy.

### 2. COMMIT and ROLLBACK

For the rollback test, I changed the status of book copy COPY004 from `AVAILABLE` to `ON_LOAN` within a transaction. I then used `ROLLBACK` to cancel the change. The copy returned to its original `AVAILABLE` status because the change had not been committed.

For the commit test, I changed COPY004 to `ON_LOAN` and used `COMMIT` to save the change. I then started another transaction, restored the status to `AVAILABLE` and committed that change as well.

These tests showed the difference between committing a change to the database and rolling back a change that has not been committed.

### 3. Transaction Isolation

I tested transaction isolation using two separate pgAdmin Query Tool sessions.

In Session A, I changed COPY004 from `AVAILABLE` to `ON_LOAN` without committing the transaction. Session A could see its own change, but Session B continued to see `AVAILABLE` because the change had not yet been committed.

After I committed the transaction in Session A, I ran the query again in Session B. This time, Session B returned `ON_LOAN`.

This behaviour is consistent with PostgreSQL's default `READ COMMITTED` isolation level. Each query sees data committed before that query begins, while uncommitted changes made by another session remain invisible. After completing the test, I restored COPY004 to `AVAILABLE`.

### 4. Concurrency Control

The database has a unique partial index named `uq_loan_one_active_per_copy` on `public.loan(copy_id)`, which applies only to rows where `return_date IS NULL`.

To test this control mechanism, I attempted to insert another active loan for COPY003, which already had an active loan. PostgreSQL rejected the insert with a duplicate-key error because the existing active loan already used that copy ID. I rolled back the failed transaction and ran a verification query, which confirmed that the original active loan remained the only active loan for COPY003.

This index prevents the same physical book copy from having multiple active loan records. It helps maintain consistency in the library's loan records.

### 5. Findings

The tests demonstrated the following:

- `ROLLBACK` cancels uncommitted changes.
- `COMMIT` saves transaction changes.
- Under `READ COMMITTED`, a query does not see uncommitted changes made by another session.
- The unique partial index prevents multiple active loan records for the same physical book copy.

After testing, COPY004 was restored to `AVAILABLE`, and the original active loan for COPY003 remained unchanged.

### 6. Conclusion

The tests showed how PostgreSQL transactions and constraints help maintain consistent records in the University Library Management System. `COMMIT` and `ROLLBACK` control whether changes are saved, `READ COMMITTED` determines which changes are visible between sessions, and the unique partial index prevents duplicate active loans for the same book copy.