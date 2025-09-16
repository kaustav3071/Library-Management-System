using System;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If admin is already logged in, redirect to books page
            if (AdminAuth.IsAdminLoggedIn)
            {
                Response.Redirect("Books.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (AdminAuth.ValidateAdmin(email, password))
            {
                AdminAuth.LoginAdmin(email);
                Response.Redirect("Books.aspx");
            }
            else
            {
                ShowError("Invalid admin credentials. Please check your email and password.");
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
        }
    }
}