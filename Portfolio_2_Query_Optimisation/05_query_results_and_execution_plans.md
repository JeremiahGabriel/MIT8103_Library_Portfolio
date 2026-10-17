# MIT8103 Advanced Database Systems

## Portfolio 2: Query Results and Execution Plans

**Case Study:** University Library Management System  
**Database:** PostgreSQL, `university_library`

### 1. Library Inventory Query

The inventory query returned three book titles with their book IDs, total copies and available copies.

| Book ID | Title | Total Copies | Available Copies |
|---|---|---:|---:|
| 3 | Database System Concepts (7th Edition) | 1 | 1 |
| 1 | Database Systems: A Practical Approach to Design, Implementation, and Management (6th Edition) | 2 | 2 |
| 2 | Operating System Concepts (9th Edition) | 1 | 0 |

The saved inventory-query screenshot records an execution time of 0.979 ms for the inventory query.

The screenshot does not provide a verified before-and-after comparison. Therefore, the available evidence does not establish a reliable execution-time comparison before and after index creation or after running `ANALYZE`.

### 2. Active Loans Query

The active-loan query returned one active loan for David Bello.

| Loan ID | Student Number | Student Name | Book | Copy ID | Loan Date | Due Date |
|---|---|---|---|---|---|---|
| 2 | STU002 | David Bello | Operating System Concepts (9th Edition) | COPY003 | 2026-09-20 | 2026-10-04 |

### 3. Overdue Loans Query

As of 16 October 2026, the query identified one overdue loan.

| Loan ID | Student | Due Date | Days Overdue | Daily Rate | Estimated Fine |
|---|---|---|---:|---:|---:|
| 2 | David Bello | 2026-10-04 | 12 | ₦100.00 | ₦1,200.00 |

The estimated fine was calculated using the number of overdue days and the configured daily rate of ₦100. The due date follows the standard 14-day loan period.

### 4. Fine and Payment Query

The fine-payment query returned two recorded fine entries.

| Fine ID | Loan ID | Student | Fine Amount | Amount Paid | Outstanding Balance | Status |
|---|---|---|---:|---:|---:|---|
| 1 | 1 | Ada Okafor | ₦0.00 | ₦0.00 | ₦0.00 | PAID |
| 2 | 2 | David Bello | ₦1,200.00 | ₦0.00 | ₦1,200.00 | UNPAID |

For loan ID 2, the recorded outstanding balance was ₦1,200.00. This matches the estimated fine for 12 overdue days at ₦100 per day as of 16 October 2026. The overdue-loan query calculates an estimate based on the overdue period, while the fine-payment query retrieves the recorded fine balance from the database.

### 5. Overdue-Loan Execution Plan

I used the following query to examine the execution plan and performance of the overdue-loan query.

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    l.loan_id,
    l.student_id,
    l.copy_id,
    l.due_date
FROM public.loan AS l
WHERE l.return_date IS NULL
  AND l.due_date < CURRENT_DATE;
```

**Original baseline results**

```text
Seq Scan on loan l
  (cost=0.00..1.03 rows=1 width=28)
  (actual time=0.108..0.109 rows=1.00 loops=1)
  Filter: ((return_date IS NULL) AND (due_date < CURRENT_DATE))
  Rows Removed by Filter: 1
  Buffers: shared hit=1
Planning Time: 0.295 ms
Execution Time: 0.143 ms
```

**Repeat test results**

```text
Seq Scan on loan l
  (cost=0.00..1.03 rows=1 width=28)
  (actual time=0.026..0.027 rows=1.00 loops=1)
  Filter: ((return_date IS NULL) AND (due_date < CURRENT_DATE))
  Rows Removed by Filter: 1
  Buffers: shared hit=1
Planning:
  Buffers: shared hit=76
Planning Time: 0.841 ms
Execution Time: 0.040 ms
```

Both plans used a sequential scan on `loan`, returned one row, filtered out one row and recorded one shared buffer hit during execution.

| Measurement | Original baseline | Repeat test |
|---|---:|---:|
| Execution time | 0.143 ms | 0.040 ms |
| Planning time | 0.295 ms | 0.841 ms |
| Shared buffers hit during execution | 1 | 1 |
| Shared buffers hit during planning | Not reported | 76 |
| Rows returned | 1 | 1 |
| Rows removed by filter | 1 | 1 |
| Scan method | Sequential | Sequential |

The repeat test took 0.040 ms, compared with 0.143 ms in the original test. Although execution time was lower, these two measurements do not establish a consistent performance change. Planning time increased from 0.295 ms to 0.841 ms, and the repeat test reported 76 shared buffer hits during planning.

The dataset is small, and the execution plans do not show the candidate index being used for this query. The recorded measurements are insufficient to determine whether the query would perform better with a larger dataset.

### 6. Indexing and Inventory Performance Findings

I created a B-tree index named `idx_bookcopy_book_id` on `bookcopy(book_id)` to examine its effect on the inventory query.

After creating the index, I ran the inventory query again and obtained the same results. PostgreSQL continued to use a sequential scan on `bookcopy`. Since the table contains only four book copies, a sequential scan is reasonable for this small dataset.

I also examined the partial index `idx_loan_active_due_date`, which covers `due_date` for rows where `return_date IS NULL`. PostgreSQL did not use this index for the overdue-loan query during the recorded tests.

The available evidence does not demonstrate a clear performance benefit from the candidate indexes. The inventory screenshot does not establish a verified before-and-after timing comparison. Larger datasets and repeated tests under consistent conditions would provide a stronger basis for evaluating index effectiveness.

### 7. Conclusion

The queries returned the documented inventory, active-loan, overdue-loan and fine-payment results. The execution plans showed how PostgreSQL processed the overdue-loan query and recorded its execution and planning times.

The tests did not establish a clear performance improvement from the new index. The available evidence supports the recorded query results and execution plans, but it does not establish a reliable before-and-after performance comparison. Further testing with a larger dataset and repeated runs under consistent conditions would provide stronger evidence of index effectiveness.