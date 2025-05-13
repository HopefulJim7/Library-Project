CREATE DATABASE LibraryDB;

USE LibraryDB;

-- Creating the tables for the library database
-- Books table to store book information
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    available BOOLEAN DEFAULT TRUE
);

-- Members table to store member information
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- Borrowings table to track which member borrowed which book
CREATE TABLE Borrowings (
]    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);


-- Inserting sample data into the Books table
USE LibraryDB;

INSERT INTO Books (title, author, isbn, available) VALUES
('The Bondage of the Will', 'Martin Luther', '978-0800759426', TRUE),
('Table Talk', 'Martin Luther', '978-0800759433', TRUE),
('Institutes of the Christian Religion', 'John Calvin', '978-0800759440', TRUE),
('A Treatise on Relics', 'John Calvin', '978-0800759457', TRUE),
('The Overcoming Life', 'Dwight L. Moody', '978-0800759464', TRUE),
('Secret Power', 'Dwight L. Moody', '978-0800759471', TRUE),
('The Great Controversy', 'Ellen White', '978-0800759488', TRUE),
('Steps to Christ', 'Ellen White', '978-0800759495', TRUE);

-- inserting borrowers into the table
INSERT INTO Members (name, email, phone, join_date) VALUES
('John Doe', 'johndoe@example.com', '0712345678', CURDATE()),
('Jane Smith', 'janesmith@example.com', '0723456789', CURDATE()),
('Michael Johnson', 'michaelj@example.com', '0734567890', CURDATE()),
('Emily Davis', 'emilyd@example.com', '0745678901', CURDATE()),
('Robert Brown', 'robertb@example.com', '0756789012', CURDATE());


INSERT INTO Borrowings (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, CURDATE(), NULL),  -- John Doe borrowed "The Bondage of the Will"
(2, 2, CURDATE(), NULL),  -- Jane Smith borrowed "Table Talk"
(3, 3, CURDATE(), CURDATE() + INTERVAL 7 DAY),  -- Michael Johnson borrowed "Institutes of the Christian Religion" (returned in 7 days)
(4, 4, CURDATE(), NULL),  -- Emily Davis borrowed "A Treatise on Relics"
(5, 5, CURDATE(), NULL);  -- Robert Brown borrowed "The Overcoming Life"

-- Inserting overdue borrowers into the table
INSERT INTO Borrowings (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, CURDATE() - INTERVAL 20 DAY, NULL),  -- John Doe borrowed "The Bondage of the Will" (Overdue)
(2, 2, CURDATE() - INTERVAL 18 DAY, NULL),  -- Jane Smith borrowed "Table Talk" (Overdue)
(3, 3, CURDATE() - INTERVAL 25 DAY, NULL),  -- Michael Johnson borrowed "Institutes of the Christian Religion" (Overdue)
(4, 4, CURDATE() - INTERVAL 30 DAY, NULL),  -- Emily Davis borrowed "A Treatise on Relics" (Overdue)
(5, 5, CURDATE() - INTERVAL 15 DAY, NULL),  -- Robert Brown borrowed "The Overcoming Life" (Overdue)
(6, 6, CURDATE() - INTERVAL 22 DAY, NULL),  -- Sarah Wilson borrowed "Secret Power" (Overdue)
(7, 7, CURDATE() - INTERVAL 19 DAY, NULL);  -- David Martinez borrowed "The Great Controversy" (Overdue)


-- - List all borrowed books
SELECT B.title, B.author, M.name, BR.borrow_date, BR.return_date
FROM Borrowings BR
JOIN Books B ON BR.book_id = B.book_id
JOIN Members M ON BR.member_id = M.member_id;

-- Find overdue books
SELECT B.title, M.name, BR.borrow_date
FROM Borrowings BR
JOIN Books B ON BR.book_id = B.book_id
JOIN Members M ON BR.member_id = M.member_id
WHERE BR.return_date IS NULL AND BR.borrow_date < CURDATE() - INTERVAL 14 DAY;