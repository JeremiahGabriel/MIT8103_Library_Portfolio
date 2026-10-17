# Portfolio 1: Database Design and Modelling

## 1. Case Study

**System Name:** University Library Management System

This portfolio covers the design and implementation of a relational database for a university library. The system manages students, staff, books, authors, categories, physical book copies, loans, returns, fines and fine rates.

## 2. Database Design

The database was implemented in PostgreSQL. It contains ten tables: `Student`, `Staff`, `Category`, `Author`, `Book`, `BookAuthor`, `BookCopy`, `Loan`, `FineRate` and `Fine`.

The design uses primary keys, foreign keys, unique constraints and other validation rules to protect data integrity. The entity-relationship diagram documents the relationships between the main entities.

## 3. Implementation and Testing

The SQL files in this folder contain the database definition, test data and related database operations. The implementation includes a partial unique index that prevents multiple active loans for the same physical book copy. A trigger prevents overlapping fine-rate periods.

The sample data supports tests involving book availability, loans, returns and fines. The standard loan period is 14 days. The configured daily overdue fine rate is ₦100, effective from 1 January 2026.

The database rules and sample operations were tested in PostgreSQL using pgAdmin. The supporting evidence and design documentation are stored in this portfolio folder.

## 4. Limitations

The database does not automatically enforce the exact 14-day loan period. Estimated overdue fines are calculated by queries and are not automatically generated or stored as new fine records. These limitations are documented in the project.

## 5. How to Review This Portfolio

1. Review the entity-relationship diagram and schema documentation.
2. Inspect the numbered SQL files to follow the database creation and test-data process.
3. Review the constraints, index and trigger definitions.
4. Examine the test evidence and supporting documentation.

Use a test database when rerunning SQL files that create tables or insert sample records. Check the contents of each script before executing it, particularly if the database already contains the sample data.

## 6. Evidence

The files and screenshots in this folder support the database design, implementation and validation work for the University Library Management System.