
# MIT8103 Advanced Database Systems

## Portfolio 2: Query Processing and Optimisation

**Case Study:** University Library Management System  
**Database:** PostgreSQL, `university_library`

### 1. Query Testing

I tested five SQL queries to check the library inventory, active loans, overdue loans, fine payments and query performance.

The inventory query returned three book titles with their categories, authors, total copies and available copies. The active-loan query returned one active loan. The overdue-loan query identified loan ID 2, belonging to David Bello, as 18 days overdue on 15 October 2026. At the configured daily rate of ₦100, the estimated fine was ₦1,800.

The fine-payment query returned two recorded fine entries. The outstanding balance for loan ID 2 was ₦1,200. This differs from the estimated fine because the overdue-loan query calculates the fine based on the number of overdue days, while the fine-payment query retrieves the balance recorded in the database.

### 2. Indexing Experiment

I created a B-tree index named `idx_bookcopy_book_id` on `bookcopy(book_id)` to check whether it would affect the inventory query.

After creating the index, I ran the inventory query again and got the same results. However, PostgreSQL continued to use a sequential scan on the `bookcopy` table. Since the table contains only four book copies, a sequential scan is reasonable for this small dataset. The test did not demonstrate a clear performance benefit from creating the index.

I also checked the existing partial index, `idx_loan_active_due_date`, which covers `due_date` for loans where `return_date IS NULL`. PostgreSQL did not use this index for the overdue-loan query during my tests.

### 3. Execution-Plan Analysis

I examined the execution plan for the overdue-loan query to see how PostgreSQL processed it. The original test used a sequential scan on `loan`. The query returned one row, filtered out one row and recorded one shared buffer hit.

| Measurement | Original baseline | Repeat test |
|---|---:|---:|
| Execution time | 0.065 ms | 0.116 ms |
| Planning time | 0.229 ms | 0.264 ms |
| Shared buffers hit | 1 | 1 |
| Rows returned | 1 | 1 |
| Scan method | Sequential | Sequential |

The repeat test took 0.116 ms, compared with 0.065 ms in the original test. Although the execution time was higher, this difference does not establish a consistent change in performance. The dataset is small, and the two measurements alone are not enough to determine whether the query became slower.

I also recorded the inventory query's execution time before and after creating the index and refreshing the table statistics with `ANALYZE`. The execution time was 0.678 ms before index creation, 0.647 ms after creating the index and 0.403 ms after running `ANALYZE`.

Although the final execution time was lower, PostgreSQL still used a sequential scan on `bookcopy`. I therefore cannot conclude that the index caused the reduction. The measurements show the differences between the tests, but further testing would be needed to establish whether the changes had a consistent effect on performance.

### 4. Findings

The tests returned the expected query results and allowed me to examine how PostgreSQL processed the queries. I created a B-tree index, checked an existing partial index and compared execution plans and timings.

The new index did not show a clear performance benefit with the current dataset. PostgreSQL continued to use sequential scans, and the recorded execution times differed between tests. With only four records in `bookcopy`, the results were not sufficient to determine how useful the index would be with a larger dataset.

The tests also showed that creating an index does not automatically make a query faster. Checking the execution plan alongside the recorded timings helped me assess the results without assuming that the index had improved performance.

### 5. Conclusion

This portfolio involved testing SQL queries, creating an index and examining query execution plans in the University Library Management System. I used the results to check query correctness and observe how PostgreSQL handled the queries before and after the database changes.

The tests did not demonstrate a clear performance improvement from the new index. Since the dataset was small, a larger dataset and repeated tests under consistent conditions would be needed to assess its effectiveness more reliably. The results provide a record of the tests carried out and the execution behaviour observed, without claiming a performance improvement that the measurements do not establish.