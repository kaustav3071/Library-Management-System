using System;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If admin is already logged in, redirect to return url or books page
            if (AdminAuth.IsAdminLoggedIn)
            {
                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl, false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
                Response.Redirect("Books.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            // Add debug logging to help troubleshoot
            System.Diagnostics.Debug.WriteLine($"Admin login attempt - Email: {email}");
            System.Diagnostics.Debug.WriteLine($"Password length: {password?.Length ?? 0}");
            
            // Debug: Check what EnvReader returns
            string expectedEmail = EnvReader.GetValue("ADMIN_EMAIL");
            string expectedPassword = EnvReader.GetValue("ADMIN_PASSWORD");
            System.Diagnostics.Debug.WriteLine($"Expected email from env: {expectedEmail}");
            System.Diagnostics.Debug.WriteLine($"Expected password length from env: {expectedPassword?.Length ?? 0}");

            if (AdminAuth.ValidateAdmin(email, password))
            {
                System.Diagnostics.Debug.WriteLine("Admin validation successful");
                AdminAuth.LoginAdmin(email);
                
                string returnUrl = Request.QueryString["ReturnUrl"];                
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    System.Diagnostics.Debug.WriteLine($"Redirecting to return URL: {returnUrl}");
                    Response.Redirect(returnUrl, false);
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Redirecting to Books.aspx");
                    Response.Redirect("Books.aspx", false);
                }
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Admin validation failed");
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