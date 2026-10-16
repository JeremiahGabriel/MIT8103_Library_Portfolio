# MIT8103 Advanced Database Systems

## Individual Practical Database Portfolio

**Case Study:** University Library Management System  
**Institution:** Miva Open University  
**Session:** 2026/2027 First Semester

## 1. Project Overview

This project involved designing and implementing a University Library Management System using PostgreSQL and MongoDB. The system manages students, staff, books, authors, categories, physical book copies, loans, returns and fines.

I completed five portfolio activities covering database design, query optimisation, transactions and concurrency, NoSQL data modelling, and cloud database deployment. I used the same library system throughout the project to apply these database concepts to a single case study.

## 2. Portfolio Activities

### Portfolio 1: Database Design

I designed the relational database for the University Library Management System using PostgreSQL. The database included tables for students, staff, categories, authors, books, book copies, loans, fine rates and fines.

I used primary keys, foreign keys, uniqueness constraints and other integrity rules to define relationships and maintain data integrity. The design also accounted for the library's business rules, including a standard loan period of 14 days and a daily overdue fine rate of ₦100 from 1 January 2026.

### Portfolio 2: Query Optimisation

I wrote and tested SQL queries to retrieve library records and examined their execution plans in PostgreSQL. I also created an index to investigate its effect on query performance.

PostgreSQL continued to use sequential scans for the queries I examined. Although some execution times decreased between tests, the results did not establish that the index caused the reduction. This exercise helped me understand why execution plans and measured results are important when evaluating query performance.

### Portfolio 3: Transactions and Concurrency

I tested transaction management and concurrency control in the library database, focusing on how PostgreSQL handles changes and protects loan records.

The tests covered `COMMIT`, `ROLLBACK`, transaction isolation across two sessions, and a partial unique index designed to prevent multiple active loans for the same physical book copy. I also compared recorded fine balances with estimated overdue fines.

These tests helped me understand how transactions and database constraints enforce the library's rules and prevent conflicting loan records.

### Portfolio 4: NoSQL and Advanced Data Models

I used MongoDB Community Server and MongoDB Compass to create a document-based model of the library's book collection. Each document stored book details, authors, categories and an array of physical copies, including their availability or loan status.

The collection contained three book documents. I tested queries to retrieve all books, filter by category, find books with available copies and find books containing copies currently on loan. This gave me practical experience with MongoDB documents, embedded arrays and queries on nested fields.

### Portfolio 5: Distributed and Cloud Database

I created a MongoDB Atlas deployment named `LibraryCloudCluster` using the Free tier on AWS in the Paris region. I exported the local NoSQL book collection to a JSON file and imported the three documents into the cloud database.

I ran three queries against the cloud collection. The category query returned two documents, the available-copy query returned two documents, and the on-loan query returned one document. All three queries returned the expected document counts for the sample collection.

The Atlas overview showed a three-node replica set with one primary and two secondary members. This provided evidence of the configured replication architecture. I did not perform a controlled failover test or configure sharding, so I recorded these as limitations rather than completed tasks.

## 3. Repository and Supporting Evidence

I organised the project files, database scripts, models, screenshots and portfolio documentation in the GitHub repository.

**GitHub repository:** [MIT8103 Library Portfolio](https://github.com/JeremiahGabriel/MIT8103_Library_Portfolio)

The repository contains the five portfolio folders, supporting scripts, evidence and project documentation. The Portfolio 5 evidence includes screenshots of the Atlas deployment, imported book collection, query results and replica-set configuration.

The repository brings together the implementation files and supporting evidence for assessment.

## 4. Individual Reflection

Working through the five portfolios helped me understand how database concepts apply to a practical information system. I learned how relational design supports business rules, how execution plans help investigate query performance, and how transactions and constraints protect loan records.

Working with MongoDB gave me a different perspective on data modelling. I learned how documents and embedded arrays store related information together and how nested-field queries retrieve specific records. Moving the collection to MongoDB Atlas also gave me experience with data migration and cloud-based queries.

One important lesson was the need to distinguish between configuring a feature and testing its behaviour. For example, the Atlas dashboard showed the replica-set configuration, but I did not carry out a failover test. I also learned to report query measurements carefully rather than assume a change had improved performance.

Throughout the project, I gained practical experience with PostgreSQL, MongoDB Compass, MongoDB Atlas, VS Code and Git. I also became more aware of the importance of verifying results and keeping evidence of the work completed.

## 5. References

MongoDB, Inc. (n.d.). *MongoDB documentation*. https://www.mongodb.com/docs/

PostgreSQL Global Development Group. (n.d.). *PostgreSQL documentation*. https://www.postgresql.org/docs/

Miva Open University. (2026). *MIT8103 Advanced Database Systems: Individual Practical Database Portfolio, 2026/2027 First Semester*. Assessment brief.

## 6. AI-Use Declaration

I used ChatGPT as a learning and development aid during this project. I used it to clarify database concepts, obtain guidance on SQL and NoSQL tasks, review query results and improve the technical documentation.

I checked the guidance against my implementation and tested database operations and queries in my local environment and MongoDB Atlas. I also reviewed and edited the documentation to reflect the work completed and distinguish between features I tested and those I discussed but did not implement.

I take responsibility for understanding, verifying and explaining the work submitted in this portfolio.