# MIT8103 Advanced Database Systems Portfolio

## Project Overview

This repository contains my individual practical portfolio for MIT8103 Advanced Database Systems at Miva Open University.

For this project, I designed and implemented a **University Library Management System** using PostgreSQL. The system manages students, staff, books, authors, categories, physical book copies, loans, returns, fines and fine rates.

The project covers database design, query processing and optimisation, transaction management, NoSQL data modelling, and distributed and cloud database concepts.

## Case Study

I chose a university library as my case study because its operations involve managing different types of related records. The database is designed to support the following activities:

- Managing student and staff records.
- Organising books by category and author.
- Keeping track of individual physical book copies.
- Recording book loans and returns.
- Tracking overdue fines and payments.
- Applying fine rates during defined periods.

PostgreSQL is used for the relational database implementation. Other database technologies will be covered in the relevant portfolio sections.

## Portfolio Structure

| Portfolio | Topic | Status |
|---|---|---|
| Portfolio 1 | Database Design and Modelling | Completed and uploaded |
| Portfolio 2 | Query Processing and Optimisation | Pending |
| Portfolio 3 | Transactions and Concurrency | Pending |
| Portfolio 4 | NoSQL and Advanced Data Models | Pending |
| Portfolio 5 | Distributed and Cloud Database Exercise | Pending |
| Final Documentation | Summary, evidence, reflection, references and AI-use declaration | Pending |

I will update the status as I complete and upload each portfolio.

## Portfolio 1: Database Design and Modelling

Portfolio 1 covers the database design, implementation and testing. It includes the following files and evidence:

- SQL scripts for creating the database tables and inserting test data.
- Checks for foreign keys and database constraints.
- Validation tests to check that the database rules work as expected.
- A partial unique index to prevent the same physical book copy from having more than one active loan.
- A trigger to prevent overlapping fine-rate periods.
- An editable entity-relationship diagram and its PNG version.
- Screenshots of the implementation and test results.
- Documentation explaining the schema, keys, constraints, normalisation, testing and limitations.

The database contains ten tables: `Student`, `Staff`, `Category`, `Author`, `Book`, `BookAuthor`, `BookCopy`, `Loan`, `FineRate` and `Fine`.

## Technologies

- PostgreSQL
- SQL
- Git and GitHub
- Visual Studio Code
- diagrams.net (draw.io)
- MongoDB, for the planned NoSQL portfolio work

## Evidence and Documentation

Each portfolio will include its implementation files, documentation and supporting evidence. Screenshots of actual database operations and test results will be used to show how the implementation works.

The `Final_Documentation` folder will contain the overall project summary, my reflection, references and AI-use declaration.

## Academic Integrity and AI Use

I used AI tools to support my learning, understand technical concepts, plan my work and review my implementation. I am responsible for understanding the database design, checking the SQL, running the tests and verifying the final work.

The final documentation will explain which AI tools I used, how they supported the project and how I reviewed and tested the resulting material.

## Project Status

Portfolio 1 has been committed to the repository. I will add the remaining portfolios as I complete them and use Git commits to keep track of changes throughout the project.
