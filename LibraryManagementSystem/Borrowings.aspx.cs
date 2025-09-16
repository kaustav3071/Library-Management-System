using System;
using System.Data;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class Borrowings : System.Web.UI.Page
    {
        private readonly BorrowingDAL borrowingDAL = new BorrowingDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require admin authentication
            AdminAuth.RequireAdmin();

            if (!IsPostBack)
            {
                LoadActiveBorrowings();
            }
        }

        private void LoadActiveBorrowings()
        {
            try
            {
                DataTable activeBorrowings = borrowingDAL.GetActiveBorrowings();
                gvActive.DataSource = activeBorrowings;
                gvActive.DataBind();
                
                System.Diagnostics.Debug.WriteLine($"Loaded {activeBorrowings.Rows.Count} active borrowings");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading active borrowings: {ex.Message}");
            }
        }

        protected void gvActive_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Return")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int id))
                {
                    try
                    {
                        if (borrowingDAL.ReturnBook(id, DateTime.Now))
                        {
                            System.Diagnostics.Debug.WriteLine($"Book returned successfully for borrowing ID: {id}");
                            LoadActiveBorrowings(); // Refresh active borrowings
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"Failed to return book for borrowing ID: {id}");
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error returning book: {ex.Message}");
                    }
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AdminAuth.LogoutAdmin();
            Response.Redirect("Welcome.aspx");
        }

        // Helper method to display member name (handles both Users and legacy Members)
        protected string GetMemberDisplayName(object userNameObj, object userIdObj, object memberIdObj)
        {
            // Check if we have a user name (from Users table)
            if (userNameObj != null && userNameObj != DBNull.Value)
            {
                string userName = userNameObj.ToString();
                if (!string.IsNullOrEmpty(userName))
                    return userName;
            }

            // Fall back to user ID or member ID display
            if (userIdObj != null && userIdObj != DBNull.Value)
            {
                return $"User #{userIdObj}";
            }
            
            if (memberIdObj != null && memberIdObj != DBNull.Value)
            {
                return $"Member #{memberIdObj}";
            }

            return "Unknown Member";
        }

        // Helper methods for status display
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