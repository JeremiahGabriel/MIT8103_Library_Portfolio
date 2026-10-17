# Portfolio 3: Transactions and Concurrency

## 1. Case Study

**System Name:** University Library Management System

This portfolio examines transaction control, isolation and concurrent access in the PostgreSQL library database.

## 2. Implementation

The exercises use PostgreSQL transactions to examine `COMMIT` and `ROLLBACK`, transaction isolation across two database sessions, and the prevention of duplicate active loans for a physical book copy.

The portfolio also considers fine-related data by comparing recorded fine balances with estimated overdue-fine calculations.

## 3. Testing

The transaction exercises demonstrate how changes are committed or rolled back. The two-session tests examine how one transaction's changes are observed by another session under the tested isolation behaviour.

The concurrency test examines the partial unique index that prevents more than one active loan for the same physical copy. An attempted duplicate active loan is used to test whether the database rejects the conflicting operation.

The recorded screenshots and test-result documents provide evidence of the database behaviour observed during these exercises.

## 4. How to Review This Portfolio

1. Open the numbered SQL files and read the instructions before running each exercise.
2. Review the transaction analysis and test-result documentation.
3. Examine the screenshots for the transaction, isolation and concurrency tests.
4. Compare the recorded outcomes with the constraints and transaction commands used.

Use the intended test database. Where an exercise uses multiple sessions, follow the documented session order. Some tests deliberately cause an error or roll back changes, so read the script comments before execution.

## 5. Findings

The exercises demonstrate the role of transaction control, isolation and database constraints in protecting the consistency of library records. The partial unique index provides a database-level rule against multiple active loans for the same physical copy.

The documented outcomes apply to the tests performed and do not imply that every possible concurrency scenario was tested.