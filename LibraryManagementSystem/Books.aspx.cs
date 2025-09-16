using System;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class Books : System.Web.UI.Page
    {
        BookDAL bookDAL = new BookDAL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Require admin authentication
            AdminAuth.RequireAdmin();

            if (!IsPostBack)
            {
                // Display admin email
                lblAdminEmail.Text = AdminAuth.AdminEmail;
                LoadBooks();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Verify admin is still logged in
            AdminAuth.RequireAdmin();

            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                bookDAL.AddBook(txtTitle.Text.Trim(), txtAuthor.Text.Trim(), txtISBN.Text.Trim());
                lblMessage.CssClass = "alert alert-success d-block";
                lblMessage.Text = "Book added!";
                ClearForm();
                LoadBooks();
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "alert alert-danger d-block";
                lblMessage.Text = ex.Message;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            AdminAuth.LogoutAdmin();
            Response.Redirect("Welcome.aspx");
        }

        private void LoadBooks()
        {
            try
            {
                gvBooks.DataSource = bookDAL.GetAllBooks();
                gvBooks.DataBind();
                lblMessage.CssClass = string.Empty;
                if (gvBooks.Rows.Count == 0)
                {
                    lblMessage.CssClass = "alert alert-info d-block";
                    lblMessage.Text = "No books found. Add one above.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "alert alert-danger d-block";
                lblMessage.Text = ex.Message;
            }
        }

        private void ClearForm()
        {
            txtTitle.Text = string.Empty;
            txtAuthor.Text = string.Empty;
            txtISBN.Text = string.Empty;
        }
    }
}