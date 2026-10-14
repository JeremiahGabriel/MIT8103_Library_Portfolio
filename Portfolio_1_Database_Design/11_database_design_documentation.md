# MIT8103 Advanced Database Systems

## Portfolio 1: Database Design and Modelling

## 1. Case Study Description

### 1.1 Selected System

The selected case study is the University Library Management System (Miva Open University, 2026). The database supports the daily work of a university library.

Students and staff borrow books for academic and research purposes. Library staff manage book records, physical copies, loans, returns and fines.

The system keeps these records in one database. It also helps the library track available books and outstanding loans.

### 1.2 Data Stored

The database contains ten tables covering students, staff, categories, authors, books, physical copies, loans, fines and fine rates.

A book title is separate from its physical copies. For example, a library with three copies of one title needs a separate record for each copy. Each record has its own identifier and borrowing status.

Books and authors have a many-to-many relationship. One book can have several authors, and one author can write several books. The `BookAuthor` table links the two.

The database also records loan dates, due dates, return dates, fine amounts and payments.

### 1.3 Main Database Operations

The database supports the following operations:

- Register and retrieve student and staff records.
- Store book, author and category details.
- Track physical copies and their status.
- Record loans, due dates and returns.
- Store fines and payments.
- Maintain daily fine rates and their effective dates.

The standard loan period is 14 days. Overdue fines use a daily rate. The database includes rules for valid dates and fine amounts. A partial unique index prevents one physical copy from having more than one active loan. A trigger prevents overlapping fine-rate periods.

The 14-day loan period is a business rule. The current database does not enforce an exact 14-day duration for every loan.

## 2. Relational Schema

The database has ten related tables. Primary keys identify records, while foreign keys link related records.

| Table | Purpose | Primary Key |
|---|---|---|
| `Student` | Stores student details | `student_id` |
| `Staff` | Stores library staff details | `staff_id` |
| `Category` | Stores book categories | `category_id` |
| `Author` | Stores author details | `author_id` |
| `Book` | Stores book titles and publication details | `book_id` |
| `BookAuthor` | Links books to authors | `book_id`, `author_id` |
| `BookCopy` | Stores physical book copies | `copy_id` |
| `Loan` | Records borrowing and returns | `loan_id` |
| `FineRate` | Stores daily rates and effective dates | `fine_rate_id` |
| `Fine` | Stores fines and payment details | `fine_id` |

### 2.1 Relationships Between Tables

Each book belongs to one category. A category can contain several books. The `Category` and `Book` tables therefore have a one-to-many relationship.

The `Book` and `Author` tables have a many-to-many relationship. The `BookAuthor` table links them through `book_id` and `author_id`. Together, these columns form its composite primary key.

One book title can have several physical copies. The `Book` and `BookCopy` tables have a one-to-many relationship.

Each `Loan` record links a student, a staff member and a physical copy. It also records the relevant dates. The `Fine` table links a fine to a loan. A unique constraint on `Fine.loan_id` limits each loan to one fine record.

The `FineRate` table stores daily rates and their effective dates. A trigger prevents overlapping rate periods.

The entity relationships appear in `University_Library_ERD.drawio`. The project also includes a PNG version of the diagram.

## 3. Keys and Constraints

Keys identify records and connect related tables. Constraints prevent duplicate or invalid data (Connolly & Begg, 2009).

### 3.1 Primary Keys

Each table has a primary key. For example, `student_id` identifies a student, `book_id` identifies a book title, and `loan_id` identifies a loan.

The `BookAuthor` table uses a composite primary key made up of `book_id` and `author_id`. It prevents duplicate links between the same book and author.

### 3.2 Foreign Keys

Foreign keys link related tables.

- `Book` references `Category`.
- `BookAuthor` references `Book` and `Author`.
- `BookCopy` references `Book`.
- `Loan` references `Student`, `Staff` and `BookCopy`.
- `Fine` references `Loan`.

For example, a loan record must refer to an existing student and physical copy. These rules maintain referential integrity.

### 3.3 Unique Constraints

The database uses unique constraints for fields such as student numbers, student email addresses, staff numbers, staff email addresses, category names and physical-copy barcodes (PostgreSQL Global Development Group, 2026a).

The Book table also has a unique constraint on isbn. The field is optional because it does not have a NOT NULL constraint. The unique constraint on `Fine.loan_id` prevents more than one fine record per loan.

### 3.4 Check Constraints and Other Rules

Check constraints reject values outside the rules defined in the database (PostgreSQL Global Development Group, 2026a). The current design checks:

- Loan dates and return dates.
- Non-negative fine amounts.
- Payment amounts between zero and the fine amount.
- Permitted fine statuses.
- Permitted physical-copy statuses.
- Publication years within the defined range.
- Non-negative fine rates and valid rate dates.

The database also has a partial unique index named `uq_loan_one_active_per_copy`. It applies to loan records where `return_date IS NULL`. It prevents the same physical copy from having two active loans (PostgreSQL Global Development Group, 2026c).

The `FineRate` table uses a trigger named `trg_prevent_overlapping_fine_rate_periods` (PostgreSQL Global Development Group, 2026b). During testing, the trigger rejected an overlapping period and accepted a valid period. The test changes were rolled back, leaving the original fine-rate record unchanged.

The database stores fine amounts and payment details. SQL queries demonstrate overdue-fine calculations using a daily rate. The database does not automatically generate every fine when a loan becomes overdue.

## 4. Database Normalisation

Normalisation helps reduce repeated data and avoid problems when records change (Connolly & Begg, 2009). The database separates information by entity and transaction.

### 4.1 First Normal Form (1NF)

First Normal Form requires each field to hold a single value rather than a list (Codd, 1970).

The database stores book details in `Book` and author details in `Author`. It does not store several author names in one book field. Instead, `BookAuthor` links each book to its authors.

This design supports books with several authors without keeping a list of names in one field.

### 4.2 Second Normal Form (2NF)

Second Normal Form requires a table to meet 1NF and each non-key attribute to depend on the whole primary key (Connolly & Begg, 2009).

The `BookAuthor` table has a composite primary key made up of `book_id` and `author_id`. It contains only these two columns, so it has no non-key attributes which depend on only part of the key.

The other tables use single-column primary keys. Partial-key dependencies are not an issue in these tables, although their non-key attributes must still depend on their respective primary keys.

### 4.3 Third Normal Form (3NF)

Third Normal Form requires a table to meet 2NF and its non-key attributes to depend on the key rather than on other non-key attributes (Connolly & Begg, 2009).

The database stores student details in `Student`, book details in `Book`, and physical-copy details in `BookCopy`. Loan records refer to students and copies instead of repeating all their details.

For example, a change to a student's email address is made in `Student`. The library does not need to change every loan record linked to the student.

Fine rates also have a separate table. This keeps rate periods apart from book and student records.

The design follows the main principles of 1NF, 2NF and 3NF through separate tables and the `BookAuthor` linking table. A formal normalisation proof would require a record of the functional dependencies for each table.

## 5. Implementation and Testing

The database was implemented in PostgreSQL. The project contains SQL scripts for creating the database and tables, checking foreign keys and constraints, inserting test data and running validation tests.

The ten tables were populated with sample records. The checks covered table relationships, inserted data and selected integrity rules.

The partial unique index was created to prevent multiple active loans for one physical copy (PostgreSQL Global Development Group, 2026c). The fine-rate trigger was tested with an overlapping period and a valid period. The overlapping period was rejected, while the valid period was accepted. The temporary test changes were rolled back.

The Portfolio 1 evidence folder contains screenshots of test-data verification, validation tests and fine-rate trigger tests. It also contains the editable ER diagram and its PNG image.

### 5.1 Implementation Limitations

The database covers the main records and selected rules for the library system. Some operations still need additional SQL or application logic.

The 14-day loan period is not enforced as an exact duration by a database constraint. The SQL examples demonstrate fine calculations, but the database does not automatically calculate and store every overdue fine.

The `Fine` table stores the fine amount and payment information. The `FineRate` table stores the daily rates and effective dates. Further logic would be needed to generate fines automatically and record which rate was applied to each fine.

## 6. References

Codd, E. F. (1970). A relational model of data for large shared data banks. *Communications of the ACM, 13*(6), 377-387. https://doi.org/10.1145/362384.362685

Connolly, T., & Begg, C. (2009). *Database systems: A practical approach to design, implementation, and management* (5th ed.). Pearson Education.

Miva Open University. (2026). *MIT8103 Advanced Database Systems: Individual practical database portfolio, 2026/2027 first semester* [Course assessment brief].

PostgreSQL Global Development Group. (2026a). *Constraints*. In *PostgreSQL documentation*. Retrieved October 14, 2026, from https://www.postgresql.org/docs/current/ddl-constraints.html

PostgreSQL Global Development Group. (2026b). *CREATE TRIGGER*. In *PostgreSQL documentation*. Retrieved October 14, 2026, from https://www.postgresql.org/docs/current/sql-createtrigger.html

PostgreSQL Global Development Group. (2026c). *Partial indexes*. In *PostgreSQL documentation*. Retrieved October 14, 2026, from https://www.postgresql.org/docs/current/indexes-partial.html

## 7. AI-Use Declaration

I used ChatGPT to help organise this report, explain database concepts and improve the wording. I reviewed the explanations against the database work, SQL scripts and test evidence. I remain responsible for checking the report, understanding the implementation and explaining the work submitted.