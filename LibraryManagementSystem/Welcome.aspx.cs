using System;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetupAuthenticationDisplay();
            }
        }

        private void SetupAuthenticationDisplay()
        {
            // Check if user is logged in
            if (UserAuth.IsUserLoggedIn)
            {
                // Show logged in user panel
                pnlUserAuth.Visible = false;
                pnlUserLoggedIn.Visible = true;
                lblUserName.Text = UserAuth.CurrentUserName ?? "User";
                
                // Update account link
                lnkUserAccount.NavigateUrl = "UserBorrowings.aspx";
                accountLinkText.InnerText = "My Dashboard";
            }
            else
            {
                // Show login/register links
                pnlUserAuth.Visible = true;
                pnlUserLoggedIn.Visible = false;
                
                // Set default account link
                lnkUserAccount.NavigateUrl = "UserLogin.aspx";
                accountLinkText.InnerText = "Sign In";
            }

            // Check if admin is logged in
            if (AdminAuth.IsAdminLoggedIn)
            {
                pnlAdminSection.Visible = true;
            }
            else
            {
                pnlAdminSection.Visible = false;
            }
        }

        protected void btnUserLogout_Click(object sender, EventArgs e)
        {
            UserAuth.LogoutUser();
            Response.Redirect(Request.RawUrl); // Refresh current page
        }
    }
}
