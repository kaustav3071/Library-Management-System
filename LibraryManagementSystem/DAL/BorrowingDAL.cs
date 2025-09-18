using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LibraryManagementSystem.DAL
{
    public class BorrowingDAL
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBConnection"].ConnectionString;

        // Record a borrowing transaction with user
        public void BorrowBook(int userId, int bookId, DateTime borrowDate, DateTime? dueDate)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("INSERT INTO Borrowings (UserId, BookId, BorrowDate, DueDate, ReturnDate) VALUES (@UserId, @BookId, @BorrowDate, @DueDate, NULL)", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@BookId", bookId);
                cmd.Parameters.AddWithValue("@BorrowDate", borrowDate);
                cmd.Parameters.AddWithValue("@DueDate", (object)dueDate ?? DBNull.Value);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Legacy method for backward compatibility
        public void BorrowBook(int memberId, int bookId, DateTime borrowDate, DateTime? dueDate, bool isLegacyMember = true)
        {
            if (isLegacyMember)
            {
                using (var conn = new SqlConnection(connectionString))
                using (var cmd = new SqlCommand("INSERT INTO Borrowings (MemberId, BookId, BorrowDate, DueDate, ReturnDate) VALUES (@MemberId, @BookId, @BorrowDate, @DueDate, NULL)", conn))
                {
                    cmd.Parameters.AddWithValue("@MemberId", memberId);
                    cmd.Parameters.AddWithValue("@BookId", bookId);
                    cmd.Parameters.AddWithValue("@BorrowDate", borrowDate);
                    cmd.Parameters.AddWithValue("@DueDate", (object)dueDate ?? DBNull.Value);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            else
            {
                BorrowBook(memberId, bookId, borrowDate, dueDate);
            }
        }

        // Mark a book as returned
        public bool ReturnBook(int borrowingId, DateTime returnDate)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Borrowings SET ReturnDate = @ReturnDate WHERE Id = @Id AND ReturnDate IS NULL", conn))
            {
                cmd.Parameters.AddWithValue("@Id", borrowingId);
                cmd.Parameters.AddWithValue("@ReturnDate", returnDate);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        // Get a single borrowing record
        public DataRow GetBorrowingById(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT TOP 1 * FROM Borrowings WHERE Id = @Id", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                var dt = new DataTable();
                da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        // Get all borrowings (for admin)
        public DataTable GetAllBorrowings()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, u.Name as UserName, u.Email as UserEmail, bk.Title as BookTitle, bk.Author as BookAuthor
                FROM Borrowings b
                LEFT JOIN Users u ON b.UserId = u.Id
                LEFT JOIN Members m ON b.MemberId = m.Id
                LEFT JOIN Books bk ON b.BookId = bk.Id
                ORDER BY b.BorrowDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }

        // Active borrowings (not returned yet)
        public DataTable GetActiveBorrowings()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, u.Name as UserName, u.Email as UserEmail, bk.Title as BookTitle, bk.Author as BookAuthor
                FROM Borrowings b
                LEFT JOIN Users u ON b.UserId = u.Id
                LEFT JOIN Members m ON b.MemberId = m.Id
                LEFT JOIN Books bk ON b.BookId = bk.Id
                WHERE b.ReturnDate IS NULL
                ORDER BY b.BorrowDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }

        // Returned borrowings (already returned)
        public DataTable GetReturnedBorrowings()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, u.Name as UserName, u.Email as UserEmail, bk.Title as BookTitle, bk.Author as BookAuthor
                FROM Borrowings b
                LEFT JOIN Users u ON b.UserId = u.Id
                LEFT JOIN Members m ON b.MemberId = m.Id
                LEFT JOIN Books bk ON b.BookId = bk.Id
                WHERE b.ReturnDate IS NOT NULL
                ORDER BY b.ReturnDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }

        // Overdue borrowings (no parameters - current date)
        public DataTable GetOverdueBorrowings()
        {
            return GetOverdueBorrowings(DateTime.Today);
        }

        // All borrowings for a given user
        public DataTable GetBorrowingsByUser(int userId)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, bk.Title as BookTitle, bk.Author as BookAuthor, bk.ISBN
                FROM Borrowings b
                INNER JOIN Books bk ON b.BookId = bk.Id
                WHERE b.UserId = @UserId
                ORDER BY b.BorrowDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                da.Fill(dt);
            }
            return dt;
        }

        // All borrowings for a given member (legacy)
        public DataTable GetBorrowingsByMember(int memberId)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Borrowings WHERE MemberId = @MemberId", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@MemberId", memberId);
                da.Fill(dt);
            }
            return dt;
        }

        // All borrowings for a given book
        public DataTable GetBorrowingsByBook(int bookId)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, u.Name as UserName, u.Email as UserEmail
                FROM Borrowings b
                LEFT JOIN Users u ON b.UserId = u.Id
                LEFT JOIN Members m ON b.MemberId = m.Id
                WHERE b.BookId = @BookId
                ORDER BY b.BorrowDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@BookId", bookId);
                da.Fill(dt);
            }
            return dt;
        }

        // Check if book is available for borrowing
        public bool IsBookAvailable(int bookId)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT COUNT(*) FROM Borrowings WHERE BookId = @BookId AND ReturnDate IS NULL", conn))
            {
                cmd.Parameters.AddWithValue("@BookId", bookId);
                conn.Open();
                int activeBorrowings = (int)cmd.ExecuteScalar();
                return activeBorrowings == 0;
            }
        }

        // Get user's active borrowings
        public DataTable GetActiveUserBorrowings(int userId)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, bk.Title as BookTitle, bk.Author as BookAuthor, bk.ISBN
                FROM Borrowings b
                INNER JOIN Books bk ON b.BookId = bk.Id
                WHERE b.UserId = @UserId AND b.ReturnDate IS NULL
                ORDER BY b.BorrowDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                da.Fill(dt);
            }
            return dt;
        }

        // Optional: delete a borrowing record (e.g., cleanup)
        public bool DeleteBorrowing(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("DELETE FROM Borrowings WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        // Overdue borrowings (DueDate < today and not returned)
        public DataTable GetOverdueBorrowings(DateTime asOf)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT b.*, u.Name as UserName, u.Email as UserEmail, bk.Title as BookTitle, bk.Author as BookAuthor
                FROM Borrowings b
                LEFT JOIN Users u ON b.UserId = u.Id
                LEFT JOIN Members m ON b.MemberId = m.Id
                INNER JOIN Books bk ON b.BookId = bk.Id
                WHERE b.DueDate IS NOT NULL AND b.DueDate < @AsOf AND b.ReturnDate IS NULL
                ORDER BY b.DueDate ASC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@AsOf", asOf);
                da.Fill(dt);
            }
            return dt;
        }

        // Get borrowing statistics for admin dashboard
        public DataTable GetBorrowingStats()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand(@"
                SELECT 
                    (SELECT COUNT(*) FROM Borrowings WHERE ReturnDate IS NULL) as ActiveBorrowings,
                    (SELECT COUNT(*) FROM Borrowings) as TotalBorrowings,
                    (SELECT COUNT(*) FROM Borrowings WHERE ReturnDate IS NOT NULL) as ReturnedBooks,
                    (SELECT COUNT(*) FROM Borrowings WHERE DueDate < GETDATE() AND ReturnDate IS NULL) as OverdueBorrowings", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }
    }
}