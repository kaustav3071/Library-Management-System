using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LibraryManagementSystem.DAL
{
    public class BookDAL
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBConnection"].ConnectionString;

        public void AddBook(string title, string author, string isbn)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("INSERT INTO Books (Title, Author, ISBN) VALUES (@Title, @Author, @ISBN)", conn))
            {
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@ISBN", isbn);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public DataTable GetAllBooks()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Books", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }

        public DataRow GetBookById(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT TOP 1 * FROM Books WHERE Id = @Id", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                var dt = new DataTable();
                da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        public bool UpdateBook(int id, string title, string author, string isbn)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Books SET Title = @Title, Author = @Author, ISBN = @ISBN WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@ISBN", isbn);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public bool DeleteBook(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("DELETE FROM Books WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public DataTable SearchBooks(string keyword)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Books WHERE Title LIKE @q OR Author LIKE @q OR ISBN LIKE @q", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                string like = "%" + (keyword ?? string.Empty) + "%";
                cmd.Parameters.AddWithValue("@q", like);
                da.Fill(dt);
            }
            return dt;
        }
    }
}