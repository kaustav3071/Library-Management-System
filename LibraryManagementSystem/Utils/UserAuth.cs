using System;
using System.Data;
using System.Web;
using LibraryManagementSystem.DAL;

namespace LibraryManagementSystem.Utils
{
    public static class UserAuth
    {
        private const string USER_SESSION_KEY = "UserLoggedIn";
        private const string USER_ID_SESSION_KEY = "UserId";
        private const string USER_NAME_SESSION_KEY = "UserName";
        private const string USER_EMAIL_SESSION_KEY = "UserEmail";

        public static bool IsUserLoggedIn
        {
            get
            {
                try
                {
                    if (HttpContext.Current?.Session == null)
                        return false;

                    var sessionValue = HttpContext.Current.Session[USER_SESSION_KEY];
                    return sessionValue != null && (bool)sessionValue;
                }
                catch
                {
                    return false;
                }
            }
        }

        public static int? CurrentUserId
        {
            get
            {
                try
                {
                    if (HttpContext.Current?.Session == null)
                        return null;

                    var userId = HttpContext.Current.Session[USER_ID_SESSION_KEY];
                    return userId != null ? (int?)Convert.ToInt32(userId) : null;
                }
                catch
                {
                    return null;
                }
            }
        }

        public static string CurrentUserName
        {
            get
            {
                try
                {
                    if (HttpContext.Current?.Session == null)
                        return null;

                    return HttpContext.Current.Session[USER_NAME_SESSION_KEY] as string;
                }
                catch
                {
                    return null;
                }
            }
        }

        public static string CurrentUserEmail
        {
            get
            {
                try
                {
                    if (HttpContext.Current?.Session == null)
                        return null;

                    return HttpContext.Current.Session[USER_EMAIL_SESSION_KEY] as string;
                }
                catch
                {
                    return null;
                }
            }
        }

        public static bool ValidateUser(string email, string password)
        {
            try
            {
                UserDAL userDAL = new UserDAL();
                DataRow user = userDAL.AuthenticateUser(email, password);
                return user != null;
            }
            catch
            {
                return false;
            }
        }

        public static void LoginUser(DataRow userData)
        {
            try
            {
                if (HttpContext.Current?.Session == null)
                    return;

                HttpContext.Current.Session[USER_SESSION_KEY] = true;
                HttpContext.Current.Session[USER_ID_SESSION_KEY] = userData["Id"];
                HttpContext.Current.Session[USER_NAME_SESSION_KEY] = userData["Name"];
                HttpContext.Current.Session[USER_EMAIL_SESSION_KEY] = userData["Email"];
                
                // Debug logging
                System.Diagnostics.Debug.WriteLine($"User logged in: {userData["Name"]} (ID: {userData["Id"]})");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in LoginUser: {ex.Message}");
                throw;
            }
        }

        public static void LogoutUser()
        {
            try
            {
                if (HttpContext.Current?.Session == null)
                    return;

                HttpContext.Current.Session[USER_SESSION_KEY] = null;
                HttpContext.Current.Session[USER_ID_SESSION_KEY] = null;
                HttpContext.Current.Session[USER_NAME_SESSION_KEY] = null;
                HttpContext.Current.Session[USER_EMAIL_SESSION_KEY] = null;
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in LogoutUser: {ex.Message}");
            }
        }

        public static void RequireLogin()
        {
            try
            {
                if (!IsUserLoggedIn)
                {
                    string currentPage = HttpContext.Current.Request.Url.AbsolutePath;
                    string loginUrl = "~/UserLogin.aspx";
                    
                    // Prevent infinite redirect loop
                    if (!currentPage.EndsWith("UserLogin.aspx", StringComparison.OrdinalIgnoreCase))
                    {
                        if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString.ToString()))
                        {
                            loginUrl += "?ReturnUrl=" + HttpContext.Current.Server.UrlEncode(HttpContext.Current.Request.RawUrl);
                        }
                        else
                        {
                            loginUrl += "?ReturnUrl=" + HttpContext.Current.Server.UrlEncode(currentPage);
                        }
                        
                        HttpContext.Current.Response.Redirect(loginUrl);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in RequireLogin: {ex.Message}");
            }
        }

        public static void RequireLoginOrAdmin()
        {
            try
            {
                if (!IsUserLoggedIn && !AdminAuth.IsAdminLoggedIn)
                {
                    string currentPage = HttpContext.Current.Request.Url.AbsolutePath;
                    if (!currentPage.EndsWith("UserLogin.aspx", StringComparison.OrdinalIgnoreCase) && 
                        !currentPage.EndsWith("AdminLogin.aspx", StringComparison.OrdinalIgnoreCase))
                    {
                        HttpContext.Current.Response.Redirect("~/UserLogin.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in RequireLoginOrAdmin: {ex.Message}");
            }
        }

        public static DataRow GetCurrentUserData()
        {
            try
            {
                if (!IsUserLoggedIn || !CurrentUserId.HasValue)
                    return null;

                UserDAL userDAL = new UserDAL();
                return userDAL.GetUserById(CurrentUserId.Value);
            }
            catch
            {
                return null;
            }
        }
    }
}