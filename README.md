# MIT8103 Advanced Database Systems Portfolio

## Project Overview

This repository contains my individual practical portfolio for MIT8103 Advanced Database Systems at Miva Open University.

The project is based on the **University Library Management System**, which I developed using PostgreSQL and MongoDB. The system covers students, staff, books, authors, categories, physical book copies, loans, returns, fines and fine rates.

The five portfolio activities cover relational database design, query optimisation, transactions and concurrency, NoSQL data modelling, and distributed and cloud database concepts.

## Case Study

I chose a university library for this project because its operations involve managing related records and enforcing rules across different parts of a database.

The system supports:

- Managing student and staff records.
- Organising books by category and author.
- Tracking individual physical book copies.
- Recording book loans and returns.
- Calculating and tracking overdue fines and payments.
- Maintaining fine rates for defined periods.

PostgreSQL is used for the relational database, while MongoDB is used for the NoSQL data model and cloud database activities.

## Portfolio Structure

| Portfolio | Topic | Status |
|---|---|---|
| Portfolio 1 | Database Design and Modelling | Completed |
| Portfolio 2 | Query Processing and Optimisation | Completed |
| Portfolio 3 | Transactions and Concurrency | Completed |
| Portfolio 4 | NoSQL and Advanced Data Models | Completed |
| Portfolio 5 | Distributed and Cloud Database | Completed |
| Final Documentation | Project summary, evidence, reflection, references and AI-use declaration | Completed |

## Portfolio 1: Database Design and Modelling

This portfolio covers the design, implementation and testing of the relational database.

The database contains ten tables: `Student`, `Staff`, `Category`, `Author`, `Book`, `BookAuthor`, `BookCopy`, `Loan`, `FineRate` and `Fine`.

The work includes SQL scripts, test data, integrity constraints, validation tests, a partial unique index to prevent multiple active loans for the same physical copy, a trigger to prevent overlapping fine-rate periods, and an entity-relationship diagram.

The SQL scripts, documentation and screenshots are stored in [Portfolio 1: Database Design](Portfolio_1_Database_Design/).

## Portfolio 2: Query Processing and Optimisation

This portfolio covers SQL query development, execution-plan analysis and index testing in PostgreSQL.

I examined query execution plans and recorded execution and planning times. The available evidence did not establish a reliable before-and-after performance comparison or demonstrate a clear performance improvement from the candidate indexes.

The scripts, results and documentation are stored in [Portfolio 2: Query Optimisation](Portfolio_2_Query_Optimisation/).

## Portfolio 3: Transactions and Concurrency

This portfolio examines how PostgreSQL handles transactions and concurrent access to the library database.

The work includes `COMMIT` and `ROLLBACK` tests, transaction isolation across two sessions, and testing the rule that prevents multiple active loans for the same physical book copy. I also compared recorded fine balances with estimated overdue fine calculations.

The scripts, test results and documentation are stored in [Portfolio 3: Transactions and Concurrency](Portfolio_3_Transactions_Concurrency/).

## Portfolio 4: NoSQL and Advanced Data Models

This portfolio uses MongoDB Community Server and MongoDB Compass to represent the library's book collection as documents.

The collection contains three book documents with book details, authors, categories and embedded physical-copy information. I tested queries for retrieving all books, filtering by category, finding available copies and finding copies currently on loan.

The implementation files and supporting evidence are stored in [Portfolio 4: NoSQL](Portfolio_4_NoSQL/).

## Portfolio 5: Distributed and Cloud Database

This portfolio uses MongoDB Atlas to deploy the NoSQL book collection to a cloud environment.

I created a cluster named `LibraryCloudCluster`, migrated the three book documents from the local MongoDB collection and tested three queries against the cloud collection. All three queries returned the expected document counts.

The Atlas overview showed a three-node replica set with one primary and two secondary members. I also examined replication, availability, consistency considerations and sharding. I did not carry out a controlled failover test or configure sharding. Both are documented as limitations of the implementation.

The implementation documentation and screenshots are stored in [Portfolio 5: Distributed and Cloud Database](Portfolio_5_Distributed_Cloud/).

## Final Documentation

The `Final_Documentation/` folder contains the overall portfolio summary, including the project overview, completed activities, supporting evidence, individual reflection, references and AI-use declaration.

The final summary is available in [Final Portfolio Summary](Final_Documentation/Final_Portfolio_Summary.md).

## Repository Organisation

The repository is organised into five portfolio folders and a final documentation folder. Each portfolio contains the relevant implementation files, documentation and supporting evidence.

I used Git to track changes and maintain a record of the project's development.

## Technologies

- PostgreSQL and SQL
- MongoDB Community Server
- MongoDB Compass
- MongoDB Atlas
- Git and GitHub
- Visual Studio Code
- diagrams.net (draw.io)

## Academic Integrity and AI Use

I used ChatGPT as a learning and development aid to clarify database concepts, obtain technical guidance, review query results and improve the project documentation.

I checked the guidance against my implementation and tested database operations and queries in my local environment and MongoDB Atlas. I also reviewed the documentation to distinguish between features I tested and features I discussed but did not implement.

I take responsibility for understanding, verifying and explaining the work submitted in this portfolio.

## GitHub Repository

This repository contains the practical work, SQL scripts, documentation, and supporting evidence for the MIT8103 Advanced Database Systems Individual Practical Database Portfolio.

**Repository URL:** https://github.com/JeremiahGabriel/MIT8103_Library_Portfolio