# MIT8103 Advanced Database Systems

**Individual Practical Database Portfolio**

**Case Study:** University Library Management System  
**Institution:** Miva Open University  
**Session:** 2026/2027 First Semester

## 1. Project Overview

This project applies relational, NoSQL, transaction, query optimisation and cloud database concepts to the University Library Management System. The system supports the management of students, staff, books, authors, categories, physical book copies, loans, returns and fines. Its key operations include searching the catalogue, recording loans and returns, tracking copy availability and calculating overdue fines.

The portfolio uses PostgreSQL for relational data and transaction exercises, MongoDB Community Server for document modelling, and MongoDB Atlas for the cloud database exercise.

## 2. Portfolio Activities

### Portfolio 1: Database Design and Modelling

A relational database was implemented in PostgreSQL. Its tables cover students, staff, categories, authors, books, book authors, physical book copies, loans, fine rates and fines. Primary keys, foreign keys, uniqueness rules and other constraints support data integrity and the relationships between entities. The design applies a standard 14-day loan period and a daily overdue fine rate of ₦100, effective from 1 January 2026. The ER diagram and schema documentation support the design.

### Portfolio 2: Query Processing and Optimisation

SQL queries were used to retrieve library information and examine query execution plans. Indexing and query behaviour were tested, and execution plans were reviewed. Sequential scans remained in some plans. Some measured execution times decreased between tests, but the results do not establish the index alone caused the changes. The small test dataset limits conclusions about performance.

### Portfolio 3: Transactions and Concurrency

PostgreSQL transactions were tested using `COMMIT` and `ROLLBACK`, alongside transaction isolation across two database sessions. A partial unique index was implemented to prevent more than one active loan for the same physical book copy. Fine-related checks compared recorded fine balances with overdue-fine estimates. These exercises show how transactions and database constraints help preserve consistent library records.

### Portfolio 4: NoSQL and Advanced Data Models

MongoDB Community Server and MongoDB Compass were used to implement a document-based representation of the library system. Book documents include book details, author and category information, and an array of physical copies with their statuses. Three book documents were created and tested with queries for all books, books in the Database Systems category, available copies and copies on loan. These queries demonstrate how embedded arrays and document fields support catalogue and availability searches.

### Portfolio 5: Distributed and Cloud Database Exercise

The MongoDB Atlas cluster `LibraryCloudCluster` was created on the Free tier in the AWS Paris region. Three book documents were exported from the local MongoDB database as JSON and imported into the Atlas database. Cloud queries returned two documents for the Database Systems category, two matching the available-copy filter, and one matching the on-loan filter. The Atlas replica set showed one primary and two secondary members. This configuration provides replica-set redundancy. Availability during a failure depends on quorum and successful primary election. A controlled failover test, sharding and a load or local-versus-cloud performance test were not performed. These are recorded as limitations rather than completed tests.

## 3. Repository and Supporting Evidence

The project repository contains portfolio folders, implementation files, README documentation and supporting evidence, including screenshots of cloud queries and the Atlas replica set.

**GitHub repository:** [MIT8103 Library Portfolio](https://github.com/JeremiahGabriel/MIT8103_Library_Portfolio)

The repository lets the assessor review the implementation and evidence for each portfolio activity. Ensure the assessor has access before submission.

## 4. Individual Technical Reflection

The project strengthened my understanding of how relational design, constraints and transaction controls protect data integrity. Query execution plans also showed me why performance claims need evidence and why small datasets limit the conclusions drawn from timing tests. MongoDB demonstrated a different way to organise related information through documents and arrays. The Atlas exercise added practical experience with cloud migration and replica-set configuration.

A key lesson was to verify database behaviour instead of relying only on configuration screens or expected results. I tested queries locally and in the cloud, reviewed the outputs, and documented untested features. The main tools used were PostgreSQL, pgAdmin, MongoDB Community Server, MongoDB Compass, MongoDB Atlas, Visual Studio Code and Git.

## 5. References

MongoDB, Inc. (n.d.). *MongoDB documentation*. https://www.mongodb.com/docs/

PostgreSQL Global Development Group. (n.d.). *PostgreSQL documentation*. https://www.postgresql.org/docs/

Miva Open University. (2026). *MIT8103 Advanced Database Systems: Individual Practical Database Portfolio, 2026/2027 First Semester* [Assessment brief].

## 6. AI-Use Declaration

ChatGPT was used as a learning and development aid to clarify database concepts, discuss SQL and NoSQL approaches, review query outputs and improve technical documentation. I checked the guidance against my implementation, tested database operations and queries locally and in MongoDB Atlas, and reviewed and edited the documentation. The report distinguishes tested features from concepts or tests not implemented. I remain responsible for the accuracy of the submission and for understanding and explaining the implementation and results.