using System;
using System.Data;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class UserBorrowings : System.Web.UI.Page
    {
        private BorrowingDAL borrowingDAL = new BorrowingDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"UserBorrowings Page_Load - IsUserLoggedIn: {UserAuth.IsUserLoggedIn}");
                
                // Require user login
                UserAuth.RequireLogin();

                if (!IsPostBack)
                {
                    LoadUserData();
                    LoadBorrowings();
                    LoadStats();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in UserBorrowings Page_Load: {ex.Message}");
                Response.Redirect("UserLogin.aspx");
            }
        }

        private void LoadUserData()
        {
            try
            {
                string userName = UserAuth.CurrentUserName ?? "User";
                lblUserName.Text = userName;
                System.Diagnostics.Debug.WriteLine($"Loaded user data: {userName}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading user data: {ex.Message}");
                lblUserName.Text = "User";
            }
        }

        private void LoadBorrowings()
        {
            try
            {
                if (!UserAuth.CurrentUserId.HasValue)
                {
                    System.Diagnostics.Debug.WriteLine("No current user ID available");
                    return;
                }

                int userId = UserAuth.CurrentUserId.Value;
                System.Diagnostics.Debug.WriteLine($"Loading borrowings for user ID: {userId}");

                // Load active borrowings
                DataTable activeBorrowings = borrowingDAL.GetActiveUserBorrowings(userId);
                gvActiveBorrowings.DataSource = activeBorrowings;
                gvActiveBorrowings.DataBind();

                // Load borrowing history
                DataTable allBorrowings = borrowingDAL.GetBorrowingsByUser(userId);
                gvBorrowingHistory.DataSource = allBorrowings;
                gvBorrowingHistory.DataBind();
                
                System.Diagnostics.Debug.WriteLine($"Loaded {activeBorrowings.Rows.Count} active borrowings and {allBorrowings.Rows.Count} total borrowings");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading borrowings: {ex.Message}");
            }
        }

        private void LoadStats()
        {
            try
            {
                if (!UserAuth.CurrentUserId.HasValue)
                    return;

                int userId = UserAuth.CurrentUserId.Value;

                // Active borrowings count
                DataTable activeBorrowings = borrowingDAL.GetActiveUserBorrowings(userId);
                lblActiveBorrowings.Text = activeBorrowings.Rows.Count.ToString();

                // Total borrowings count
                DataTable allBorrowings = borrowingDAL.GetBorrowingsByUser(userId);
                lblTotalBorrowings.Text = allBorrowings.Rows.Count.ToString();

                // Overdue books count
                int overdueCount = 0;
                DateTime today = DateTime.Today;
                foreach (DataRow row in activeBorrowings.Rows)
                {
                    if (row["DueDate"] != DBNull.Value)
                    {
                        DateTime dueDate = Convert.ToDateTime(row["DueDate"]);
                        if (dueDate < today)
                        {
                            overdueCount++;
                        }
                    }
                }
                lblOverdueBooks.Text = overdueCount.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading stats: {ex.Message}");
                lblActiveBorrowings.Text = "0";
                lblTotalBorrowings.Text = "0";
                lblOverdueBooks.Text = "0";
            }
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserProfile.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            UserAuth.LogoutUser();
            Response.Redirect("Welcome.aspx");
        }

        // Helper methods for status display
        protected string GetStatusClass(object dueDateObj)
        {
            if (dueDateObj == DBNull.Value)
                return "status-badge status-normal";

            DateTime dueDate = Convert.ToDateTime(dueDateObj);
            DateTime today = DateTime.Today;

            if (dueDate < today)
                return "status-badge status-overdue";
            else if (dueDate <= today.AddDays(3))
                return "status-badge status-due-soon";
            else
                return "status-badge status-normal";
        }

        protected string GetStatusText(object dueDateObj)
        {
            if (dueDateObj == DBNull.Value)
                return "Active";

            DateTime dueDate = Convert.ToDateTime(dueDateObj);
            DateTime today = DateTime.Today;

            if (dueDate < today)
            {
                int daysOverdue = (today - dueDate).Days;
                return $"Overdue ({daysOverdue} day{(daysOverdue > 1 ? "s" : "")})";
            }
            else if (dueDate <= today.AddDays(3))
            {
                int daysLeft = (dueDate - today).Days;
                return $"Due in {daysLeft} day{(daysLeft > 1 ? "s" : "")}";
            }
            else
                return "Active";
        }

        protected string GetHistoryStatusClass(object returnDateObj, object dueDateObj)
        {
            if (returnDateObj == DBNull.Value)
                return GetStatusClass(dueDateObj);

            DateTime returnDate = Convert.ToDateTime(returnDateObj);
            
            if (dueDateObj != DBNull.Value)
            {
                DateTime dueDate = Convert.ToDateTime(dueDateObj);
                if (returnDate > dueDate)
                    return "status-badge status-returned-late";
            }

            return "status-badge status-returned";
        }

        protected string GetHistoryStatusText(object returnDateObj, object dueDateObj)
        {
            if (returnDateObj == DBNull.Value)
                return GetStatusText(dueDateObj);

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