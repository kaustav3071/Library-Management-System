using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace LibraryManagementSystem.DAL
{
    public class UserDAL
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBConnection"].ConnectionString;

        // Hash password using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        // Register new user
        public bool RegisterUser(string name, string email, string phone, string password)
        {
            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    // Check if email already exists
                    using (var checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        conn.Open();
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            throw new Exception("Email already exists.");
                        }
                    }

                    // Insert new user
                    using (var cmd = new SqlCommand("INSERT INTO Users (Name, Email, Phone, PasswordHash, CreatedDate, IsActive) VALUES (@Name, @Email, @Phone, @PasswordHash, @CreatedDate, 1)", conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Phone", phone ?? string.Empty);
                        cmd.Parameters.AddWithValue("@PasswordHash", HashPassword(password));
                        cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                        cmd.ExecuteNonQuery();
                    }
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        // Authenticate user login
        public DataRow AuthenticateUser(string email, string password)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Users WHERE Email = @Email AND PasswordHash = @PasswordHash AND IsActive = 1", conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", HashPassword(password));
                
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt.Rows.Count > 0 ? dt.Rows[0] : null;
                }
            }
        }

        // Get user by ID (for active users only - for authentication)
        public DataRow GetUserById(int userId)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Users WHERE Id = @Id AND IsActive = 1", conn))
            {
                cmd.Parameters.AddWithValue("@Id", userId);
                
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt.Rows.Count > 0 ? dt.Rows[0] : null;
                }
            }
        }

        // Get user by ID regardless of status (for admin operations)
        public DataRow GetUserByIdForAdmin(int userId)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Users WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", userId);
                
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt.Rows.Count > 0 ? dt.Rows[0] : null;
                }
            }
        }

        // Get user by email
        public DataRow GetUserByEmail(string email)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT * FROM Users WHERE Email = @Email AND IsActive = 1", conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                
                using (var da = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    return dt.Rows.Count > 0 ? dt.Rows[0] : null;
                }
            }
        }

        // Get all users (for admin)
        public DataTable GetAllUsers()
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT Id, Name, Email, Phone, CreatedDate, IsActive FROM Users ORDER BY CreatedDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        // Update user profile
        public bool UpdateUserProfile(int userId, string name, string phone)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Users SET Name = @Name, Phone = @Phone WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Phone", phone ?? string.Empty);
                cmd.Parameters.AddWithValue("@Id", userId);
                
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        // Deactivate user (soft delete)
        public bool DeactivateUser(int userId)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Users SET IsActive = 0 WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", userId);
                
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        // Activate user
        public bool ActivateUser(int userId)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("UPDATE Users SET IsActive = 1 WHERE Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", userId);
                
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                return rows > 0;
            }
        }

        // Toggle user status (activate/deactivate)
        public bool ToggleUserStatus(int userId)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();
                
                // First get current status
                using (var getCmd = new SqlCommand("SELECT IsActive FROM Users WHERE Id = @Id", conn))
                {
                    getCmd.Parameters.AddWithValue("@Id", userId);
                    object result = getCmd.ExecuteScalar();
                    
                    if (result == null)
                        return false; // User not found
                    
                    bool currentStatus = Convert.ToBoolean(result);
                    bool newStatus = !currentStatus; // Toggle the status
                    
                    // Update with new status
                    using (var updateCmd = new SqlCommand("UPDATE Users SET IsActive = @NewStatus WHERE Id = @Id", conn))
                    {
                        updateCmd.Parameters.AddWithValue("@NewStatus", newStatus);
                        updateCmd.Parameters.AddWithValue("@Id", userId);
                        
                        int rows = updateCmd.ExecuteNonQuery();
                        return rows > 0;
                    }
                }
            }
        }

        // Change password
        public bool ChangePassword(int userId, string currentPassword, string newPassword)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                // Verify current password
                using (var checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Id = @Id AND PasswordHash = @CurrentHash", conn))
                {
                    checkCmd.Parameters.AddWithValue("@Id", userId);
                    checkCmd.Parameters.AddWithValue("@CurrentHash", HashPassword(currentPassword));
                    
                    conn.Open();
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count == 0)
                    {
                        return false; // Current password is incorrect
                    }
                }

                // Update password
                using (var cmd = new SqlCommand("UPDATE Users SET PasswordHash = @NewHash WHERE Id = @Id", conn))
                {
                    cmd.Parameters.AddWithValue("@NewHash", HashPassword(newPassword));
                    cmd.Parameters.AddWithValue("@Id", userId);
                    
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0;
                }
            }
        }

        // Search users (for admin)
        public DataTable SearchUsers(string keyword)
        {
            using (var conn = new SqlConnection(connectionString))
            using (var cmd = new SqlCommand("SELECT Id, Name, Email, Phone, CreatedDate, IsActive FROM Users WHERE Name LIKE @q OR Email LIKE @q ORDER BY CreatedDate DESC", conn))
            using (var da = new SqlDataAdapter(cmd))
            {
                string like = "%" + (keyword ?? string.Empty) + "%";
                cmd.Parameters.AddWithValue("@q", like);
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }
    }
}