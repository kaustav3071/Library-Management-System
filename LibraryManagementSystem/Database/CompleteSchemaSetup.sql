-- Complete Database Schema for Library Management System
-- This script creates all tables with the correct structure

USE LibraryDB; -- Change to your database name
GO

-- Drop existing tables in correct order (foreign keys first)
IF EXISTS (SELECT * FROM sysobjects WHERE name='Borrowings' AND xtype='U')
    DROP TABLE Borrowings;

IF EXISTS (SELECT * FROM sysobjects WHERE name='Books' AND xtype='U')
    DROP TABLE Books;

IF EXISTS (SELECT * FROM sysobjects WHERE name='Members' AND xtype='U')
    DROP TABLE Members;

IF EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
    DROP TABLE Users;

-- Create Users table
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(20),
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1
);

-- Create Members table (legacy)
CREATE TABLE Members (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20)
);

-- Create Books table
CREATE TABLE Books (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    ISBN NVARCHAR(50) NOT NULL
);

-- Create Borrowings table with both UserId and MemberId support
CREATE TABLE Borrowings (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NULL,                    -- For new user system
    MemberId INT NULL,                  -- For legacy member system
    BookId INT NOT NULL,
    BorrowDate DATETIME NOT NULL DEFAULT GETDATE(),
    DueDate DATETIME NULL,
    ReturnDate DATETIME NULL,
    
    -- Foreign key constraints
    CONSTRAINT FK_Borrowings_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
    CONSTRAINT FK_Borrowings_Members FOREIGN KEY (MemberId) REFERENCES Members(Id),
    CONSTRAINT FK_Borrowings_Books FOREIGN KEY (BookId) REFERENCES Books(Id)
);

-- Create indexes for better performance
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Users_IsActive ON Users(IsActive);
CREATE INDEX IX_Books_Title ON Books(Title);
CREATE INDEX IX_Books_Author ON Books(Author);
CREATE INDEX IX_Borrowings_UserId ON Borrowings(UserId);
CREATE INDEX IX_Borrowings_MemberId ON Borrowings(MemberId);
CREATE INDEX IX_Borrowings_BookId ON Borrowings(BookId);
CREATE INDEX IX_Borrowings_BorrowDate ON Borrowings(BorrowDate);

-- Insert sample data
-- Sample Users (password: password123)
INSERT INTO Users (Name, Email, Phone, PasswordHash, IsActive) VALUES 
('John Doe', 'john.doe@email.com', '+1-555-0101', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1),
('Jane Smith', 'jane.smith@email.com', '+1-555-0102', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1),
('Test User', 'test@example.com', '+1-555-0100', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1);

-- Sample Books
INSERT INTO Books (Title, Author, ISBN) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', '978-0-7432-7356-5'),
('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4'),
('1984', 'George Orwell', '978-0-452-28423-4'),
('Pride and Prejudice', 'Jane Austen', '978-0-14-143951-8'),
('The Catcher in the Rye', 'J.D. Salinger', '978-0-316-76948-0');

-- Sample Members (legacy)
INSERT INTO Members (Name, Email, Phone) VALUES 
('Legacy Member 1', 'legacy1@email.com', '+1-555-0201'),
('Legacy Member 2', 'legacy2@email.com', '+1-555-0202');

PRINT 'Database schema created successfully!';
PRINT 'Sample data inserted.';
PRINT 'User credentials - Email: test@example.com, Password: password123';

-- Display table structures
SELECT 'Users' as TableName, COLUMN_NAME as ColumnName, DATA_TYPE as DataType, IS_NULLABLE as IsNullable
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users'
UNION ALL
SELECT 'Books' as TableName, COLUMN_NAME as ColumnName, DATA_TYPE as DataType, IS_NULLABLE as IsNullable
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Books'
UNION ALL
SELECT 'Borrowings' as TableName, COLUMN_NAME as ColumnName, DATA_TYPE as DataType, IS_NULLABLE as IsNullable
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Borrowings'
ORDER BY TableName, ColumnName;