using System;
using System.Web;
using LibraryManagementSystem.Utils;

namespace LibraryManagementSystem.Utils
{
    public static class AdminAuth
    {
        private const string ADMIN_SESSION_KEY = "AdminLoggedIn";
        private const string ADMIN_EMAIL_SESSION_KEY = "AdminEmail";

        public static bool IsAdminLoggedIn
        {
            get
            {
                return HttpContext.Current.Session[ADMIN_SESSION_KEY] != null &&
                       (bool)HttpContext.Current.Session[ADMIN_SESSION_KEY];
            }
        }

        public static string AdminEmail
        {
            get
            {
                return HttpContext.Current.Session[ADMIN_EMAIL_SESSION_KEY] as string;
            }
        }

        public static bool ValidateAdmin(string email, string password)
        {
            string adminEmail = EnvReader.GetValue("ADMIN_EMAIL");
            string adminPassword = EnvReader.GetValue("ADMIN_PASSWORD");

            return !string.IsNullOrEmpty(adminEmail) && 
                   !string.IsNullOrEmpty(adminPassword) &&
                   string.Equals(email, adminEmail, StringComparison.OrdinalIgnoreCase) &&
                   password == adminPassword;
        }

        public static void LoginAdmin(string email)
        {
            HttpContext.Current.Session[ADMIN_SESSION_KEY] = true;
            HttpContext.Current.Session[ADMIN_EMAIL_SESSION_KEY] = email;
        }

        public static void LogoutAdmin()
        {
            HttpContext.Current.Session[ADMIN_SESSION_KEY] = null;
            HttpContext.Current.Session[ADMIN_EMAIL_SESSION_KEY] = null;
            HttpContext.Current.Session.Abandon();
        }

        public static void RequireAdmin()
        {
            if (!IsAdminLoggedIn)
            {
                var ctx = HttpContext.Current;
                var requestedUrl = ctx?.Request?.RawUrl ?? "~/Books.aspx";
                string loginUrl = "~/AdminLogin.aspx?ReturnUrl=" + HttpUtility.UrlEncode(requestedUrl);
                ctx.Response.Redirect(loginUrl, false);
                ctx.ApplicationInstance.CompleteRequest();
            }
        }
    }
}