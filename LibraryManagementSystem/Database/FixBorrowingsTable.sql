-- SQL Script to fix Borrowings table by adding UserId column
-- Run this in SQL Server Management Studio or your database tool

USE LibraryDB; -- Change to your database name
GO

-- Check if UserId column exists in Borrowings table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Borrowings' AND COLUMN_NAME = 'UserId')
BEGIN
    -- Add UserId column to Borrowings table
    ALTER TABLE Borrowings ADD UserId INT NULL;
    PRINT 'UserId column added to Borrowings table.';
    
    -- Add foreign key constraint
    ALTER TABLE Borrowings 
    ADD CONSTRAINT FK_Borrowings_Users 
    FOREIGN KEY (UserId) REFERENCES Users(Id);
    PRINT 'Foreign key constraint added.';
    
    -- Create index for better performance
    CREATE INDEX IX_Borrowings_UserId ON Borrowings(UserId);
    PRINT 'Index created on UserId column.';
END
ELSE
BEGIN
    PRINT 'UserId column already exists in Borrowings table.';
END

-- Display current Borrowings table structure
SELECT 
    COLUMN_NAME as ColumnName,
    DATA_TYPE as DataType,
    IS_NULLABLE as IsNullable,
    COLUMN_DEFAULT as DefaultValue,
    CHARACTER_MAXIMUM_LENGTH as MaxLength
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Borrowings'
ORDER BY ORDINAL_POSITION;

PRINT 'Borrowings table structure updated successfully!';