-- SQL Script to create Users table and update Borrowings table for Library Management System

-- Create Users table for authentication
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    CREATE TABLE Users (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        Phone NVARCHAR(20),
        PasswordHash NVARCHAR(255) NOT NULL,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        IsActive BIT NOT NULL DEFAULT 1
    );
    
    PRINT 'Users table created successfully.';
END
ELSE
BEGIN
    PRINT 'Users table already exists.';
END

-- Add UserId column to Borrowings table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Borrowings' AND COLUMN_NAME = 'UserId')
BEGIN
    ALTER TABLE Borrowings ADD UserId INT;
    
    -- Add foreign key constraint
    ALTER TABLE Borrowings 
    ADD CONSTRAINT FK_Borrowings_Users 
    FOREIGN KEY (UserId) REFERENCES Users(Id);
    
    PRINT 'UserId column added to Borrowings table.';
END
ELSE
BEGIN
    PRINT 'UserId column already exists in Borrowings table.';
END

-- Create indexes for better performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Email')
BEGIN
    CREATE INDEX IX_Users_Email ON Users(Email);
    PRINT 'Index created on Users.Email.';
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_IsActive')
BEGIN
    CREATE INDEX IX_Users_IsActive ON Users(IsActive);
    PRINT 'Index created on Users.IsActive.';
END

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Borrowings_UserId')
BEGIN
    CREATE INDEX IX_Borrowings_UserId ON Borrowings(UserId);
    PRINT 'Index created on Borrowings.UserId.';
END

-- Sample data insertion (optional - remove in production)
-- Note: Password hash for 'password123' using SHA256
IF NOT EXISTS (SELECT * FROM Users WHERE Email = 'john.doe@email.com')
BEGIN
    INSERT INTO Users (Name, Email, Phone, PasswordHash, IsActive) VALUES 
    ('John Doe', 'john.doe@email.com', '+1-555-0101', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1),
    ('Jane Smith', 'jane.smith@email.com', '+1-555-0102', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1),
    ('Alice Johnson', 'alice.johnson@email.com', '+1-555-0103', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1);
    
    PRINT 'Sample users inserted. Default password for all users: password123';
END

PRINT 'Database schema update completed successfully.';

-- Display table structure
SELECT 
    'Users' as TableName,
    COLUMN_NAME as ColumnName,
    DATA_TYPE as DataType,
    IS_NULLABLE as IsNullable,
    COLUMN_DEFAULT as DefaultValue
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Users'

UNION ALL

SELECT 
    'Borrowings' as TableName,
    COLUMN_NAME as ColumnName,
    DATA_TYPE as DataType,
    IS_NULLABLE as IsNullable,
    COLUMN_DEFAULT as DefaultValue
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Borrowings'
ORDER BY TableName, ORDINAL_POSITION;