# MIT8103 Advanced Database Systems

## Portfolio 2: Query Processing and Optimisation

**Case Study:** University Library Management System  
**Database:** PostgreSQL, `university_library`

### 1. Query Testing

I tested five SQL queries to check the library inventory, active loans, overdue loans, fine payments and query performance.

The inventory query returned three book titles with their categories, authors, total copies and available copies. The active-loan query returned one active loan. The overdue-loan query identified loan ID 2, belonging to David Bello, as 12 days overdue on 16 October 2026. At the configured daily rate of ₦100, the estimated fine was ₦1,200.

The fine-payment query returned two recorded fine entries. The outstanding balance for loan ID 2 was ₦1,200. This matches the estimated fine for 12 overdue days at ₦100 per day. The overdue-loan query calculates the estimated fine based on the number of overdue days, while the fine-payment query retrieves the balance recorded in the database.

### 2. Indexing Experiment

I created a B-tree index named `idx_bookcopy_book_id` on `bookcopy(book_id)` to check whether it would affect the inventory query.

After creating the index, I ran the inventory query again and got the same results. However, PostgreSQL continued to use a sequential scan on the `bookcopy` table. Since the table contains only four book copies, a sequential scan is reasonable for this small dataset. The test did not demonstrate a clear performance benefit from creating the index.

I also checked the existing partial index, `idx_loan_active_due_date`, which covers `due_date` for loans where `return_date IS NULL`. PostgreSQL did not use this index for the overdue-loan query during my tests.

### 3. Execution-Plan Analysis

I examined the execution plan for the overdue-loan query to see how PostgreSQL processed it. Both tests used a sequential scan on `loan`. The query returned one row, filtered out one row and recorded one shared buffer hit during execution.

| Measurement | Original baseline | Repeat test |
|---|---:|---:|
| Execution time | 0.143 ms | 0.040 ms |
| Planning time | 0.295 ms | 0.841 ms |
| Shared buffers hit during execution | 1 | 1 |
| Shared buffers hit during planning | Not reported | 76 |
| Rows returned | 1 | 1 |
| Rows removed by filter | 1 | 1 |
| Scan method | Sequential | Sequential |

The repeat test took 0.040 ms, compared with 0.143 ms in the original test. Although the execution time was lower, this difference does not establish a consistent change in performance. Planning time increased from 0.295 ms to 0.841 ms, and the repeat test reported 76 shared buffer hits during planning. The dataset is small, and the two measurements alone are not enough to determine whether the query became faster.

The saved inventory-query screenshot records an execution time of 0.979 ms. However, the available evidence does not establish a verified before-and-after comparison before index creation, after index creation and after running `ANALYZE`. PostgreSQL continued to use a sequential scan on `bookcopy`, which contains only four book copies. Therefore, the recorded evidence does not establish a clear performance improvement from the index.

### 4. Findings

The tests returned the expected query results and allowed me to examine how PostgreSQL processed the queries. I created a B-tree index, checked an existing partial index and compared execution plans and timings.

The new index did not show a clear performance benefit with the current dataset. PostgreSQL continued to use sequential scans, and the recorded execution times differed between tests. With only four records in `bookcopy`, the results were not sufficient to determine how useful the index would be with a larger dataset.

The tests also showed that creating an index does not automatically make a query faster. Checking the execution plan alongside the recorded timings helped me assess the results without assuming that the index had improved performance.

### 5. Conclusion

This portfolio involved testing SQL queries, creating an index and examining query execution plans in the University Library Management System. I used the results to check query correctness and observe how PostgreSQL handled the queries before and after the database changes.

The tests did not demonstrate a clear performance improvement from the new index. Since the dataset was small, a larger dataset and repeated tests under consistent conditions would be needed to assess its effectiveness more reliably. The results provide a record of the tests carried out and the execution behaviour observed, without claiming a performance improvement which the measurements do not establish.