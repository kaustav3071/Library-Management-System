using System;
using System.Data;
using LibraryManagementSystem.DAL;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class UserLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // If user is already logged in, redirect to borrowings
                if (UserAuth.IsUserLoggedIn)
                {
                    string returnUrl = Request.QueryString["ReturnUrl"];
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl);
                    }
                    else
                    {
                        Response.Redirect("UserBorrowings.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in Page_Load: {ex.Message}");
                ShowError("An error occurred. Please try again.");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                System.Diagnostics.Debug.WriteLine($"Attempting login for email: {email}");
                
                UserDAL userDAL = new UserDAL();
                DataRow user = userDAL.AuthenticateUser(email, password);

                if (user != null)
                {
                    System.Diagnostics.Debug.WriteLine($"User authenticated: {user["Name"]}");
                    
                    // Login the user
                    UserAuth.LoginUser(user);
                    
                    System.Diagnostics.Debug.WriteLine($"Session set. IsUserLoggedIn: {UserAuth.IsUserLoggedIn}");
                    
                    // Small delay to ensure session is set
                    System.Threading.Thread.Sleep(100);
                    
                    // Redirect to the page they were trying to access, or default to borrowings
                    string returnUrl = Request.QueryString["ReturnUrl"];
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        System.Diagnostics.Debug.WriteLine($"Redirecting to return URL: {returnUrl}");
                        Response.Redirect(returnUrl, false);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("Redirecting to UserBorrowings.aspx");
                        Response.Redirect("UserBorrowings.aspx", false);
                    }
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Authentication failed - user is null");
                    ShowError("Invalid email or password. Please try again.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                ShowError("Login failed: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            try
            {
                lblError.Text = message;
                pnlError.Visible = true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error showing error message: {ex.Message}");
            }
        }
    }
}