-- MIT8103 Advanced Database Systems
-- Portfolio 1: University Library Management System
-- Purpose: Populate the database with test records

-- 1. Students (fictional)
INSERT INTO Student
    (student_number, first_name, last_name, email, phone)
VALUES
    ('STU001', 'Ada', 'Okafor', 'ada.okafor@example.com', '08030000001'),
    ('STU002', 'David', 'Bello', 'david.bello@example.com', '08030000002'),
    ('STU003', 'Mary', 'Ibrahim', 'mary.ibrahim@example.com', '08030000003');

-- 2. Library staff (fictional)
INSERT INTO Staff
    (staff_number, first_name, last_name, email, role)
VALUES
    ('STF001', 'Grace', 'Adeyemi', 'grace.adeyemi@example.com', 'Librarian'),
    ('STF002', 'John', 'Musa', 'john.musa@example.com', 'Assistant Librarian');

-- 3. Book categories
INSERT INTO Category
    (category_name, description)
VALUES
    ('Database Systems', 'Books about databases and data management'),
    ('Computer Science', 'General computing and computer science books'),
    ('Information Technology', 'Books about IT systems and applications');

-- 4. Authors
INSERT INTO Author
    (first_name, last_name, biography)
VALUES
    ('Thomas', 'Connolly', 'Co-author of Database Systems: A Practical Approach to Design, Implementation, and Management'),
    ('Carolyn', 'Begg', 'Co-author of Database Systems: A Practical Approach to Design, Implementation, and Management'),
    ('Abraham', 'Silberschatz', 'Co-author of Operating System Concepts and Database System Concepts'),
    ('Peter', 'Galvin', 'Co-author of Operating System Concepts'),
    ('Greg', 'Gagne', 'Co-author of Operating System Concepts'),
    ('Henry', 'Korth', 'Co-author of Database System Concepts'),
    ('S.', 'Sudarshan', 'Co-author of Database System Concepts');

-- 5. Books
INSERT INTO Book
    (isbn, title, category_id, publication_year, publisher)
VALUES
    (
        '9780132943260',
        'Database Systems: A Practical Approach to Design, Implementation, and Management (6th Edition)',
        (SELECT category_id FROM Category
         WHERE category_name = 'Database Systems'),
        2014,
        'Pearson'
    ),
    (
        '9781118063330',
        'Operating System Concepts (9th Edition)',
        (SELECT category_id FROM Category
         WHERE category_name = 'Computer Science'),
        2012,
        'Wiley'
    ),
    (
        '9780078022159',
        'Database System Concepts (7th Edition)',
        (SELECT category_id FROM Category
         WHERE category_name = 'Database Systems'),
        2019,
        'McGraw-Hill Education'
    );

-- 6. Relationships between books and authors
INSERT INTO BookAuthor (book_id, author_id)
VALUES
    -- Database Systems (Connolly & Begg)
    (
        (SELECT book_id FROM Book WHERE isbn = '9780132943260'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Thomas' AND last_name = 'Connolly')
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9780132943260'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Carolyn' AND last_name = 'Begg')
    ),
    -- Operating System Concepts (Silberschatz, Galvin, Gagne)
    (
        (SELECT book_id FROM Book WHERE isbn = '9781118063330'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Abraham' AND last_name = 'Silberschatz')
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9781118063330'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Peter' AND last_name = 'Galvin')
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9781118063330'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Greg' AND last_name = 'Gagne')
    ),
    -- Database System Concepts (Silberschatz, Korth, Sudarshan)
    (
        (SELECT book_id FROM Book WHERE isbn = '9780078022159'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Abraham' AND last_name = 'Silberschatz')
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9780078022159'),
        (SELECT author_id FROM Author
         WHERE first_name = 'Henry' AND last_name = 'Korth')
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9780078022159'),
        (SELECT author_id FROM Author
         WHERE first_name = 'S.' AND last_name = 'Sudarshan')
    );

-- 7. Physical book copies
INSERT INTO BookCopy (book_id, barcode, copy_status)
VALUES
    (
        (SELECT book_id FROM Book WHERE isbn = '9780132943260'),
        'COPY001',
        'AVAILABLE'
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9780132943260'),
        'COPY002',
        'AVAILABLE'
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9781118063330'),
        'COPY003',
        'ON_LOAN'
    ),
    (
        (SELECT book_id FROM Book WHERE isbn = '9780078022159'),
        'COPY004',
        'AVAILABLE'
    );

-- 8. Loans and returns
INSERT INTO Loan
    (copy_id, student_id, staff_id, loan_date, due_date, return_date)
VALUES
    (
        (SELECT copy_id FROM BookCopy WHERE barcode = 'COPY001'),
        (SELECT student_id FROM Student WHERE student_number = 'STU001'),
        (SELECT staff_id FROM Staff WHERE staff_number = 'STF001'),
        DATE '2026-09-01',
        DATE '2026-09-08',
        DATE '2026-09-07'
    ),
    (
        (SELECT copy_id FROM BookCopy WHERE barcode = 'COPY003'),
        (SELECT student_id FROM Student WHERE student_number = 'STU002'),
        (SELECT staff_id FROM Staff WHERE staff_number = 'STF002'),
        DATE '2026-09-20',
        DATE '2026-09-27',
        NULL
    );

-- 9. Fine rates
INSERT INTO FineRate
    (daily_rate, effective_from, effective_to)
VALUES
    (100.00, DATE '2026-01-01', NULL);

-- 10. Fines
INSERT INTO Fine
    (loan_id, amount, amount_paid, fine_status)
VALUES
    (
        (SELECT loan_id FROM Loan
         WHERE copy_id = (
             SELECT copy_id FROM BookCopy WHERE barcode = 'COPY001'
         )),
        0.00,
        0.00,
        'PAID'
    ),
    (
        (SELECT loan_id FROM Loan
         WHERE copy_id = (
             SELECT copy_id FROM BookCopy WHERE barcode = 'COPY003'
         )),
        1200.00,
        0.00,
        'UNPAID'
    );