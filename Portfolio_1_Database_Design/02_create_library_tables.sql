-- MIT8103 Advanced Database Systems
-- University Library Management System
-- Portfolio 1: Database Design
-- File: 02_create_library_tables.sql

-- 1. Students
CREATE TABLE Student (
    student_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Library staff
CREATE TABLE Staff (
    staff_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    staff_number VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 3. Book categories
CREATE TABLE Category (
    category_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- 4. Authors
CREATE TABLE Author (
    author_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT
);

-- 5. Books
CREATE TABLE Book (
    book_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    category_id BIGINT NOT NULL,
    publication_year INTEGER,
    publisher VARCHAR(150),
    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id)
        REFERENCES Category(category_id),
    CONSTRAINT chk_book_publication_year
        CHECK (
            publication_year IS NULL
            OR publication_year BETWEEN 1000 AND 2100
        )
);

-- 6. Book-author relationships
CREATE TABLE BookAuthor (
    book_id BIGINT NOT NULL,
    author_id BIGINT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_bookauthor_book
        FOREIGN KEY (book_id)
        REFERENCES Book(book_id),
    CONSTRAINT fk_bookauthor_author
        FOREIGN KEY (author_id)
        REFERENCES Author(author_id)
);

-- 7. Physical copies of books
CREATE TABLE BookCopy (
    copy_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id BIGINT NOT NULL,
    barcode VARCHAR(50) NOT NULL UNIQUE,
    copy_status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE',
    CONSTRAINT fk_bookcopy_book
        FOREIGN KEY (book_id)
        REFERENCES Book(book_id),
    CONSTRAINT chk_bookcopy_status
        CHECK (
            copy_status IN (
                'AVAILABLE',
                'ON_LOAN',
                'LOST',
                'DAMAGED'
            )
        )
);

-- 8. Book loans and returns
CREATE TABLE Loan (
    loan_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    copy_id BIGINT NOT NULL,
    student_id BIGINT NOT NULL,
    staff_id BIGINT NOT NULL,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    CONSTRAINT fk_loan_copy
        FOREIGN KEY (copy_id)
        REFERENCES BookCopy(copy_id),
    CONSTRAINT fk_loan_student
        FOREIGN KEY (student_id)
        REFERENCES Student(student_id),
    CONSTRAINT fk_loan_staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id),
    CONSTRAINT chk_loan_due_date
        CHECK (due_date >= loan_date),
    CONSTRAINT chk_loan_return_date
        CHECK (return_date IS NULL OR return_date >= loan_date)
);

-- 9. Configurable daily fine rates
CREATE TABLE FineRate (
    fine_rate_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    daily_rate NUMERIC(10, 2) NOT NULL,
    effective_from DATE NOT NULL,
    effective_to DATE,
    CONSTRAINT chk_fine_rate_nonnegative
        CHECK (daily_rate >= 0),
    CONSTRAINT chk_fine_rate_dates
        CHECK (
            effective_to IS NULL
            OR effective_to >= effective_from
        )
);

-- 10. Fines associated with loans
CREATE TABLE Fine (
    fine_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id BIGINT NOT NULL UNIQUE,
    amount NUMERIC(10, 2) NOT NULL DEFAULT 0,
    amount_paid NUMERIC(10, 2) NOT NULL DEFAULT 0,
    fine_status VARCHAR(20) NOT NULL DEFAULT 'UNPAID',
    CONSTRAINT fk_fine_loan
        FOREIGN KEY (loan_id)
        REFERENCES Loan(loan_id),
    CONSTRAINT chk_fine_amount
        CHECK (amount >= 0),
    CONSTRAINT chk_fine_amount_paid
        CHECK (amount_paid >= 0 AND amount_paid <= amount),
    CONSTRAINT chk_fine_status
        CHECK (
            fine_status IN (
                'UNPAID',
                'PARTIALLY_PAID',
                'PAID',
                'WAIVED'
            )
        )
);