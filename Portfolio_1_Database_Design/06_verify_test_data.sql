-- MIT8103 Advanced Database Systems
-- Portfolio 1: Verify inserted test data
-- Database: university_library

SELECT 'Student' AS table_name, COUNT(*) AS total_records
FROM Student

UNION ALL

SELECT 'Staff', COUNT(*) FROM Staff

UNION ALL

SELECT 'Category', COUNT(*) FROM Category

UNION ALL

SELECT 'Author', COUNT(*) FROM Author

UNION ALL

SELECT 'Book', COUNT(*) FROM Book

UNION ALL

SELECT 'BookAuthor', COUNT(*) FROM BookAuthor

UNION ALL

SELECT 'BookCopy', COUNT(*) FROM BookCopy

UNION ALL

SELECT 'Loan', COUNT(*) FROM Loan

UNION ALL

SELECT 'FineRate', COUNT(*) FROM FineRate

UNION ALL

SELECT 'Fine', COUNT(*) FROM Fine

ORDER BY table_name;