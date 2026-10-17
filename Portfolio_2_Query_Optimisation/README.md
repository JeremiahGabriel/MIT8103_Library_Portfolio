# Portfolio 2: Query Processing and Optimisation

## 1. Case Study

**System Name:** University Library Management System

This portfolio examines SQL query results, execution plans and index behaviour in the PostgreSQL database `university_library`.

## 2. Implementation

The SQL scripts test library inventory, active loans, overdue loans and fine-payment information. The portfolio also examines execution plans using PostgreSQL's `EXPLAIN (ANALYZE, BUFFERS)` command.

Two indexes are relevant to the tests:

- `idx_bookcopy_book_id` on `public.bookcopy(book_id)`.
- `idx_loan_active_due_date` on `public.loan(due_date)` for rows where `return_date IS NULL`.

The index definitions are checked through PostgreSQL's index catalogue. The inventory-related tables are analysed with `ANALYZE` to refresh statistics.

## 3. Testing and Results

The queries returned the documented library inventory, active-loan, overdue-loan and fine-payment results. The overdue-loan test identified one overdue loan as of 16 October 2026, with 12 overdue days and an estimated fine of ₦1,200 at ₦100 per day.

The overdue-loan execution plans used sequential scans in both recorded tests. Execution time changed from 0.143 ms to 0.040 ms, but these measurements do not prove a consistent performance improvement.

The saved inventory-query screenshot records an execution time of 0.979 ms. The available screenshot does not establish a reliable before-and-after timing comparison for the fuller inventory query. The documentation therefore avoids claiming a verified improvement from index creation.

## 4. How to Review This Portfolio

1. Read `01_baseline_queries.sql` to inspect the baseline queries.
2. Read `02_index_optimisation.sql` to review index creation, verification and statistics updates.
3. Read `04_performance_analysis.md` for the interpretation of the tests.
4. Read `05_query_results_and_execution_plans.md` for the recorded query results and execution-plan outputs.
5. Review the `evidence` folder for the supporting screenshots.

Run SQL scripts only against the intended test database. Review the commands before execution, as index creation and statistics updates change database state.

## 5. Findings

The tests demonstrate query execution and index inspection. They do not establish a clear performance benefit from the candidate indexes with the small sample dataset. Larger datasets and repeated tests under consistent conditions would be needed for stronger performance conclusions.