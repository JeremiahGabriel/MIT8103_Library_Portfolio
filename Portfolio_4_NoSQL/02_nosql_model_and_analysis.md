# Portfolio 4: NoSQL and Advanced Data Models

## 1. Introduction

In this portfolio, I used MongoDB to demonstrate document-based storage and querying of book information for the University Library Management System. The existing system uses PostgreSQL for its main library records, while MongoDB provides a way to store book details and physical copies together in a document.

I created three book documents in the `university_library_nosql` database, inside the `books` collection. Each document contains the book's details and an array of its physical copies.

## 2. NoSQL Data Model

I used a document-based structure in MongoDB. Each book document contains the following fields:

- `book_id`: the book's identifier in the library model.
- `title`, `edition` and `isbn`: the book's bibliographic details.
- `authors`: an array of author names.
- `category`: the book's subject category.
- `copies`: an array containing physical-copy identifiers, barcodes and availability statuses.

The `copies` array is embedded in the book document, so the book's details and its physical copies can be retrieved together without a separate join operation.

MongoDB also creates an `_id` field for each document. This field uniquely identifies the document within the collection.

## 3. Implementation and Query Testing

I created the `university_library_nosql` database and the `books` collection using MongoDB Compass. I then inserted three book documents based on the book records used in the University Library Management System.

I prepared four queries in `01_mongodb_queries.js` to test document retrieval and filtering.

**Query 1: Retrieve all books**

The empty filter `{}` returns all documents in the collection. With the three documents inserted, the query returns three books.

**Query 2: Filter books by category**

The filter `{ "category": "Database Systems" }` returns Book IDs 1 and 3 because both belong to the Database Systems category.

**Query 3: Find books with available copies**

The filter `{ "copies.status": "AVAILABLE" }` returns Book IDs 1 and 3. Both documents contain at least one physical copy with an `AVAILABLE` status.

**Query 4: Find books with copies on loan**

The filter `{ "copies.status": "ON_LOAN" }` returns Book ID 2, which contains the physical copy `COPY003` with an `ON_LOAN` status.

The category and available-copy queries return the same two books in this dataset. However, they check different fields and conditions. The results reflect the sample records rather than a limitation of the queries.

I tested the queries in MongoDB Compass and captured screenshots of the documents and query results as evidence.

## 4. Suitability of the Document Model

The document model allows me to store each book's details and its physical-copy information together. The embedded `authors` and `copies` arrays support books with different numbers of authors and physical copies. This keeps related information together and simplifies retrieval when an application needs the book and its copies at the same time.

MongoDB can query nested fields such as `copies.status`, which makes it straightforward to find books containing available copies or copies currently on loan.

One consideration is how physical copies are managed. If individual copies need to be updated frequently or linked to loans and returns, storing them in a separate collection may be more suitable. For this portfolio, embedding copies provides a straightforward way to demonstrate MongoDB's document structure and nested-field queries.

## 5. Comparison with PostgreSQL

PostgreSQL remains suitable for the main library transactions because students, staff, loans, returns and fines have structured relationships. Foreign keys, constraints and transactions help maintain consistency between these records.

MongoDB provides a different approach by storing related book information in a single document. This makes it convenient to retrieve a book alongside its authors and physical copies without combining multiple relational tables.

In this project, PostgreSQL serves as the main relational database for transactional records, while MongoDB demonstrates document storage and queries on nested data. The two models have different strengths, and the more suitable choice depends on how the application stores, retrieves and updates its data.

## 6. Conclusion

This portfolio demonstrates how I structured book information in MongoDB, inserted three book documents and prepared four queries to retrieve and filter the records. The queries cover retrieving all books, filtering by category and finding documents containing copies with specific availability statuses.

Working with this model also shows how embedding related information can simplify retrieval, while the way physical copies relate to loans and returns remains an important design consideration. MongoDB provides a useful document-based approach for the book records, while PostgreSQL remains appropriate for the library's relational and transactional data. However, the model does not replace the need for appropriate relationships and transaction controls when managing loans, returns and fines.