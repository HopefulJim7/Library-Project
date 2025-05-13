# 📚 Library Management System using MySQL

📂 Repository Structure
📦 Library-Management-System  
 ┣ 📜 erd_diagram.png (or link in README)  
 ┣ 📜 library_management.sql  
 ┣ 📜 README.md  

## 📖 Project Description
This project is a **Library Management System** built using **MySQL**. It allows users to:
- Store book records (title, author, availability).
- Manage members who borrow books.
- Track borrowing transactions, including overdue books.
- Maintain relationships between books, members, and borrowings using **relational database design**.

## 🚀 How to Run/Setup the Project

### 1️⃣ Import the SQL Database
1. **Download the SQL file** (`library_management.sql`).
2. Open **MySQL Workbench** or any MySQL client.
3. Create a new database:
   ```sql
   CREATE DATABASE LibraryDB;
   USE LibraryDB;

- Import the SQL file into MySQL.
2️⃣ Run Queries
Once the database is set up, you can run queries like:
📌 List all borrowed books:
SELECT B.title, B.author, M.name, BR.borrow_date, BR.return_date
FROM Borrowings BR
JOIN Books B ON BR.book_id = B.book_id
JOIN Members M ON BR.member_id = M.member_id;


📌 Find overdue books:
SELECT B.title, M.name, BR.borrow_date
FROM Borrowings BR
JOIN Books B ON BR.book_id = B.book_id
JOIN Members M ON BR.member_id = M.member_id
WHERE BR.return_date IS NULL AND BR.borrow_date < CURDATE() - INTERVAL 14 DAY;  


---

