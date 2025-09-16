using System;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class UserRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already logged in, redirect to borrowings
            if (UserAuth.IsUserLoggedIn)
            {
                Response.Redirect("UserBorrowings.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                UserDAL userDAL = new UserDAL();
                bool success = userDAL.RegisterUser(name, email, phone, password);

                if (success)
                {
                    ShowSuccess("Account created successfully! You can now sign in.");
                    ClearForm();
                }
                else
                {
                    ShowError("Registration failed. Please try again.");
                }
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
            pnlSuccess.Visible = false;
        }

        private void ShowSuccess(string message)
        {
            lblSuccess.Text = message;
            pnlSuccess.Visible = true;
            pnlError.Visible = false;
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
        }
    }
}