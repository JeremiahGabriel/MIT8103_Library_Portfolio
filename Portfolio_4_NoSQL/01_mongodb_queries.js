
/*
University Library Management System
Portfolio 4: NoSQL and Advanced Data Models
MongoDB query demonstrations
*/

const library = db.getSiblingDB("university_library_nosql");

// Query 1: Retrieve all book documents.
print("QUERY 1: All books");
library.books.find({}).forEach(printjson);

// Query 2: Find books in the Database Systems category.
print("QUERY 2: Books in the Database Systems category");
library.books.find({
    category: "Database Systems"
}).forEach(printjson);

// Query 3: Find books with at least one available physical copy.
print("QUERY 3: Books with available copies");
library.books.find({
    "copies.status": "AVAILABLE"
}).forEach(printjson);

// Query 4: Find books with at least one copy currently on loan.
print("QUERY 4: Books with copies on loan");
library.books.find({
    "copies.status": "ON_LOAN"
}).forEach(printjson);
