using System;
using System.Data;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class BookCatalog : System.Web.UI.Page
    {
        private BookDAL bookDAL = new BookDAL();
        private BorrowingDAL borrowingDAL = new BorrowingDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetupUserInterface();
                LoadBooks();
            }
        }

        private void SetupUserInterface()
        {
            if (UserAuth.IsUserLoggedIn)
            {
                // Show user header
                pnlUserHeader.Visible = true;
                pnlGuestHeader.Visible = false;
                lblUserName.Text = UserAuth.CurrentUserName ?? "User";
                lnkMyBooks.NavigateUrl = "UserBorrowings.aspx";
                lnkMyBooks.Text = "<i class='fas fa-list mr-2'></i>My Books";
            }
            else
            {
                // Show guest header
                pnlUserHeader.Visible = false;
                pnlGuestHeader.Visible = true;
                lnkMyBooks.NavigateUrl = "UserLogin.aspx";
                lnkMyBooks.Text = "<i class='fas fa-sign-in-alt mr-2'></i>Sign In";
            }
        }

        private void LoadBooks()
        {
            try
            {
                DataTable books = bookDAL.GetAllBooks();
                gvBooks.DataSource = books;
                gvBooks.DataBind();

                if (books.Rows.Count == 0)
                {
                    ShowMessage("No books are currently available in the catalog.");
                }
                else
                {
                    pnlMessage.Visible = false;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading books: " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                try
                {
                    DataTable books = bookDAL.SearchBooks(searchTerm);
                    gvBooks.DataSource = books;
                    gvBooks.DataBind();

                    if (books.Rows.Count == 0)
                    {
                        ShowMessage($"No books found matching '{searchTerm}'. Try different search terms.");
                    }
                    else
                    {
                        pnlMessage.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    ShowMessage("Error searching books: " + ex.Message);
                }
            }
            else
            {
                LoadBooks();
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            LoadBooks();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            UserAuth.LogoutUser();
            Response.Redirect(Request.RawUrl); // Refresh current page
        }

        protected void gvBooks_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "BorrowBook")
            {
                if (!UserAuth.IsUserLoggedIn)
                {
                    Response.Redirect("UserLogin.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                    return;
                }

                int bookId = Convert.ToInt32(e.CommandArgument);
                BorrowBook(bookId);
            }
        }

        private void BorrowBook(int bookId)
        {
            try
            {
                // Check if book is available
                if (!borrowingDAL.IsBookAvailable(bookId))
                {
                    ShowMessage("This book is currently not available for borrowing.");
                    return;
                }

                // Check if user already has this book
                int userId = UserAuth.CurrentUserId.Value;
                DataTable userBorrowings = borrowingDAL.GetActiveUserBorrowings(userId);
                foreach (DataRow row in userBorrowings.Rows)
                {
                    if (Convert.ToInt32(row["BookId"]) == bookId)
                    {
                        ShowMessage("You have already borrowed this book.");
                        return;
                    }
                }

                // Borrow the book (due in 14 days)
                DateTime borrowDate = DateTime.Today;
                DateTime dueDate = borrowDate.AddDays(14);
                
                borrowingDAL.BorrowBook(userId, bookId, borrowDate, dueDate);
                
                ShowMessage("Book borrowed successfully! Due date: " + dueDate.ToString("MMM dd, yyyy"));
                LoadBooks(); // Refresh the grid
            }
            catch (Exception ex)
            {
                ShowMessage("Error borrowing book: " + ex.Message);
            }
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            pnlMessage.Visible = true;
        }

        // Helper methods for book availability display
        protected string GetAvailabilityClass(object bookIdObj)
        {
            int bookId = Convert.ToInt32(bookIdObj);
            bool isAvailable = borrowingDAL.IsBookAvailable(bookId);
            return isAvailable ? "availability-badge available" : "availability-badge borrowed";
        }

        protected string GetAvailabilityText(object bookIdObj)
        {
            int bookId = Convert.ToInt32(bookIdObj);
            bool isAvailable = borrowingDAL.IsBookAvailable(bookId);
            return isAvailable ? "Available" : "Borrowed";
        }

        protected string GetBorrowButtonClass(object bookIdObj)
        {
            if (!UserAuth.IsUserLoggedIn)
                return "btn btn-sm btn-secondary";

            int bookId = Convert.ToInt32(bookIdObj);
            bool isAvailable = borrowingDAL.IsBookAvailable(bookId);
            return isAvailable ? "btn btn-sm btn-success" : "btn btn-sm btn-secondary";
        }

        protected string GetBorrowButtonText(object bookIdObj)
        {
            if (!UserAuth.IsUserLoggedIn)
                return "Sign In to Borrow";

            int bookId = Convert.ToInt32(bookIdObj);
            bool isAvailable = borrowingDAL.IsBookAvailable(bookId);
            return isAvailable ? "Borrow" : "Not Available";
        }

        protected bool CanBorrowBook(object bookIdObj)
        {
            if (!UserAuth.IsUserLoggedIn)
                return false;

            int bookId = Convert.ToInt32(bookIdObj);
            return borrowingDAL.IsBookAvailable(bookId);
        }

        protected string GetBorrowConfirmScript(object titleObj)
        {
            if (!UserAuth.IsUserLoggedIn)
                return "";

            string title = titleObj.ToString();
            return $"return confirm('Are you sure you want to borrow \"{title}\"?');";
        }
    }
}