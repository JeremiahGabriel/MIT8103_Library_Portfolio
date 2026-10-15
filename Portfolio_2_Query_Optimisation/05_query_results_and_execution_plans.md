# MIT8103 Advanced Database Systems

## Portfolio 2: Query Results and Execution Plans

**Case Study:** University Library Management System  
**Database:** PostgreSQL, `university_library`

### 1. Library Inventory Query

The query returned three book titles with their categories and copy availability.

| Book ID | Title | Category | Total Copies | Available Copies |
|---|---|---|---:|---:|
| 3 | Database System Concepts (7th Edition) | Database Systems | 1 | 1 |
| 1 | Database Systems: A Practical Approach to Design, Implementation, and Management (6th Edition) | Database Systems | 2 | 2 |
| 2 | Operating System Concepts (9th Edition) | Computer Science | 1 | 0 |

### 2. Active Loans Query

The query returned one active loan for David Bello.

| Loan ID | Student Number | Student Name | Book | Copy ID | Loan Date | Due Date |
|---|---|---|---|---|---|---|
| 2 | STU002 | David Bello | Operating System Concepts (9th Edition) | COPY003 | 2026-09-20 | 2026-09-27 |

### 3. Overdue Loans Query

As of 15 October 2026, the query identified one overdue loan.

| Loan ID | Student | Due Date | Days Overdue | Daily Rate | Estimated Fine |
|---|---|---|---:|---:|---:|
| 2 | David Bello | 2026-09-27 | 18 | ₦100.00 | ₦1,800.00 |

The estimated fine was calculated using the number of overdue days and the configured daily rate of ₦100.

### 4. Fine and Payment Query

The query returned two recorded fine entries.

| Fine ID | Loan ID | Student | Fine Amount | Amount Paid | Outstanding Balance | Status |
|---|---|---|---:|---:|---:|---|
| 1 | 1 | Ada Okafor | ₦0.00 | ₦0.00 | ₦0.00 | PAID |
| 2 | 2 | David Bello | ₦1,200.00 | ₦0.00 | ₦1,200.00 | UNPAID |

For loan ID 2, the recorded outstanding balance was ₦1,200.00, while the overdue-loan query estimated a current fine of ₦1,800.00. The two values come from different queries: one retrieves the recorded fine balance, while the other calculates an estimate based on the overdue period.

### 5. Overdue-Loan Execution Plan

I used the following query to examine the execution plan and performance of the overdue-loan query:

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
  (actual time=0.037..0.038 rows=1.00 loops=1)
  Filter: ((return_date IS NULL) AND (due_date < CURRENT_DATE))
  Rows Removed by Filter: 1
  Buffers: shared hit=1
Planning Time: 0.229 ms
Execution Time: 0.065 ms
```

**Repeat test results**

```text
Seq Scan on loan l
  (cost=0.00..1.03 rows=1 width=28)
  (actual time=0.034..0.036 rows=1.00 loops=1)
  Filter: ((return_date IS NULL) AND (due_date < CURRENT_DATE))
  Rows Removed by Filter: 1
  Buffers: shared hit=1
Planning Time: 0.264 ms
Execution Time: 0.116 ms
```

Both plans used a sequential scan on `loan`, returned one row, filtered out one row and recorded one shared buffer hit. The total execution time increased from 0.065 ms to 0.116 ms in the repeat test. These measurements do not establish a consistent performance change, and the plan does not show the index being used.

### 6. Inventory Query Performance

The inventory query produced the following execution times during testing.

| Test | Execution Time |
|---|---:|
| Before index creation | 0.678 ms |
| After index creation | 0.647 ms |
| After running `ANALYZE` | 0.403 ms |

PostgreSQL continued to use a sequential scan on `bookcopy` after the index was created. Although the lowest execution time was recorded after running `ANALYZE`, the measurements do not establish that either the index or the statistics update caused the reduction. The table contains only four book copies, so further testing with a larger dataset would be needed to assess the index's effectiveness.

### 7. Evidence Summary

The query results documented the library inventory, active loans, overdue loans and recorded fine balances. The execution plans showed the scan method, rows filtered, buffer activity and recorded execution times.

The tests did not demonstrate a clear performance benefit from the candidate index. Testing with a larger dataset and repeated runs under consistent conditions would provide a more reliable basis for evaluating its effectiveness.
