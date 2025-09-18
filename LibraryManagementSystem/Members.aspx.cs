using System;
using System.Data;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class Members : System.Web.UI.Page
    {
        private UserDAL userDAL = new UserDAL();
        private BorrowingDAL borrowingDAL = new BorrowingDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require admin authentication
            AdminAuth.RequireAdmin();

            if (!IsPostBack)
            {
                // Display admin email
                lblAdminEmail.Text = AdminAuth.AdminEmail;
                LoadUsers();
                LoadStats();
            }
        }

        private void LoadUsers()
        {
            try
            {
                DataTable users = userDAL.GetAllUsers();
                gvUsers.DataSource = users;
                gvUsers.DataBind();
                
                System.Diagnostics.Debug.WriteLine($"Loaded {users.Rows.Count} users for admin display");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading users: {ex.Message}");
            }
        }

        private void LoadStats()
        {
            try
            {
                // Get user statistics
                DataTable allUsers = userDAL.GetAllUsers();
                lblTotalUsers.Text = allUsers.Rows.Count.ToString();

                int activeUsers = 0;
                foreach (DataRow row in allUsers.Rows)
                {
                    if (Convert.ToBoolean(row["IsActive"]))
                        activeUsers++;
                }
                lblActiveUsers.Text = activeUsers.ToString();

                // Get borrowing statistics
                DataTable borrowingStats = borrowingDAL.GetBorrowingStats();
                if (borrowingStats.Rows.Count > 0)
                {
                    DataRow stats = borrowingStats.Rows[0];
                    lblActiveBorrowings.Text = stats["ActiveBorrowings"].ToString();
                    lblOverdueBooks.Text = stats["OverdueBorrowings"].ToString();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading stats: {ex.Message}");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                try
                {
                    DataTable users = userDAL.SearchUsers(keyword);
                    gvUsers.DataSource = users;
                    gvUsers.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error searching users: {ex.Message}");
                }
            }
            else
            {
                LoadUsers();
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            LoadUsers();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AdminAuth.LogoutAdmin();
            Response.Redirect("Welcome.aspx");
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int userId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewBorrowings")
            {
                ShowUserBorrowings(userId);
            }
            else if (e.CommandName == "ToggleStatus")
            {
                ToggleUserStatus(userId);
            }
        }

        private void ShowUserBorrowings(int userId)
        {
            try
            {
                // Get user name (use admin method to get inactive users too)
                DataRow user = userDAL.GetUserByIdForAdmin(userId);
                if (user != null)
                {
                    lblSelectedUserName.Text = user["Name"].ToString();
                    
                    // Get user borrowings
                    DataTable borrowings = borrowingDAL.GetBorrowingsByUser(userId);
                    gvUserBorrowings.DataSource = borrowings;
                    gvUserBorrowings.DataBind();
                    
                    // Show modal
                    pnlUserBorrowings.Style["display"] = "block";
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error showing user borrowings: {ex.Message}");
            }
        }

        private void ToggleUserStatus(int userId)
        {
            try
            {
                // Use the new toggle method
                bool success = userDAL.ToggleUserStatus(userId);
                
                if (success)
                {
                    System.Diagnostics.Debug.WriteLine($"Successfully toggled status for user {userId}");
                    LoadUsers(); // Refresh the grid
                    LoadStats(); // Refresh the statistics
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"Failed to toggle status for user {userId}");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error toggling user status: {ex.Message}");
            }
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlUserBorrowings.Style["display"] = "none";
        }

        // Helper methods for status display
        protected string GetUserStatusClass(object isActiveObj)
        {
            bool isActive = Convert.ToBoolean(isActiveObj);
            return isActive ? "status-badge status-active" : "status-badge status-inactive";
        }

        protected string GetUserStatusText(object isActiveObj)
        {
            bool isActive = Convert.ToBoolean(isActiveObj);
            return isActive ? "Active" : "Inactive";
        }

        // Added: icon helper for user status
        protected string GetUserStatusIcon(object isActiveObj)
        {
            bool isActive = Convert.ToBoolean(isActiveObj);
            return isActive ? "fas fa-user-check" : "fas fa-user-slash";
        }

        protected string GetBorrowingStatusClass(object returnDateObj, object dueDateObj)
        {
            if (returnDateObj == DBNull.Value)
            {
                // Book not returned yet
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (dueDate < DateTime.Today)
                        return "status-badge status-overdue";
                    else if (dueDate <= DateTime.Today.AddDays(3))
                        return "status-badge status-due-soon";
                }
                return "status-badge status-active";
            }
            else
            {
                // Book returned
                DateTime returnDate = Convert.ToDateTime(returnDateObj);
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (returnDate > dueDate)
                        return "status-badge status-returned-late";
                }
                return "status-badge status-returned";
            }
        }

        // Added: icon helper for borrowing status
        protected string GetBorrowingStatusIcon(object returnDateObj, object dueDateObj)
        {
            if (returnDateObj == DBNull.Value)
            {
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (dueDate < DateTime.Today)
                        return "fas fa-exclamation-triangle"; // overdue
                    else if (dueDate <= DateTime.Today.AddDays(3))
                        return "fas fa-hourglass-half"; // due soon
                }
                return "fas fa-book-reader"; // active
            }
            else
            {
                DateTime returnDate = Convert.ToDateTime(returnDateObj);
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (returnDate > dueDate)
                        return "fas fa-clock"; // returned late
                }
                return "fas fa-check-circle"; // returned
            }
        }

        protected string GetBorrowingStatusText(object returnDateObj, object dueDateObj)
        {
            if (returnDateObj == DBNull.Value)
            {
                // Book not returned yet
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (dueDate < DateTime.Today)
                    {
                        int daysOverdue = (DateTime.Today - dueDate).Days;
                        return $"Overdue ({daysOverdue} day{(daysOverdue > 1 ? "s" : "")})";
                    }
                    else if (dueDate <= DateTime.Today.AddDays(3))
                    {
                        int daysLeft = (dueDate - DateTime.Today).Days;
                        return $"Due in {daysLeft} day{(daysLeft > 1 ? "s" : "")}";
                    }
                }
                return "Active";
            }
            else
            {
                // Book returned
                DateTime returnDate = Convert.ToDateTime(returnDateObj);
                if (dueDateObj != DBNull.Value)
                {
                    DateTime dueDate = Convert.ToDateTime(dueDateObj);
                    if (returnDate > dueDate)
                    {
                        int daysLate = (returnDate - dueDate).Days;
                        return $"Returned Late ({daysLate} day{(daysLate > 1 ? "s" : "")})";
                    }
                }
                return "Returned";
            }
        }
    }
}