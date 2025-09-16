using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LibraryManagementSystem.DAL
{
    public class MemberDAL
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBConnection"].ConnectionString;

        public void AddMember(string name, string email, string phone)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("INSERT INTO Members (Name, Email, Phone) VALUES (@Name, @Email, @Phone)", conn))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", (object)(phone ?? string.Empty));
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public DataTable GetAllMembers()
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Members", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }
            return dt;
        }

        public DataRow GetMemberById(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT TOP 1 * FROM Members WHERE Id = @Id", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                var dt = new DataTable();
                da.Fill(dt);
                return dt.Rows.Count > 0 ? dt.Rows[0] : null;
            }
        }

        public bool UpdateMember(int id, string name, string email, string phone)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Members SET Name = @Name, Email = @Email, Phone = @Phone WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", (object)(phone ?? string.Empty));
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public bool DeleteMember(int id)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("DELETE FROM Members WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        public DataTable SearchMembers(string keyword)
        {
            var dt = new DataTable();
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Members WHERE Name LIKE @q OR Email LIKE @q OR Phone LIKE @q", conn))
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