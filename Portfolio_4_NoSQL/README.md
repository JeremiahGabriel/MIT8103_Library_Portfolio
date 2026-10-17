# Portfolio 4: NoSQL and Advanced Data Models

## 1. Case Study

**System Name:** University Library Management System

This portfolio represents selected library data in MongoDB using a document-based data model.

## 2. Document Model

The work uses MongoDB Community Server and MongoDB Compass. The `books` collection in the `university_library_nosql` database contains three book documents.

Each document includes book details, category and author information, and embedded physical-copy information. The copy information includes statuses used to distinguish available copies from copies currently on loan.

This structure demonstrates how related information can be stored within a document and how embedded arrays support queries involving physical copies.

## 3. Query Testing

The queries cover retrieving all books, filtering books by category, finding available copies and finding copies currently on loan.

The test results and screenshots document the query behaviour in MongoDB Compass. The evidence supports the use of document fields and embedded copy information to retrieve the sample library data.

## 4. How to Review This Portfolio

1. Review the NoSQL modelling documentation.
2. Inspect the query examples and their explanations.
3. Open MongoDB Compass and connect to the local MongoDB instance if you want to reproduce the tests.
4. Select the `university_library_nosql` database and its `books` collection.
5. Compare the query results with the saved screenshots and analysis.

Confirm the database and collection before running queries. Use the documented sample data and avoid replacing or deleting existing records unintentionally.

## 5. Findings and Limitations

The three book documents demonstrate a document-oriented representation of the library catalogue and physical-copy status. The queries show how category fields and embedded copy information support retrieval.

The portfolio uses a small sample collection. The results demonstrate the tested query behaviour but do not establish performance at larger scale.