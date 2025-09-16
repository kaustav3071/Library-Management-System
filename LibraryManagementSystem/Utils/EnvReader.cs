using System;
using System.Collections.Generic;
using System.IO;
using System.Web;

namespace LibraryManagementSystem.Utils
{
    public static class EnvReader
    {
        private static Dictionary<string, string> _envVariables;

        static EnvReader()
        {
            LoadEnvFile();
        }

        private static void LoadEnvFile()
        {
            _envVariables = new Dictionary<string, string>();
            
            try
            {
                string envPath = HttpContext.Current.Server.MapPath("~/.env");
                if (File.Exists(envPath))
                {
                    string[] lines = File.ReadAllLines(envPath);
                    foreach (string line in lines)
                    {
                        if (!string.IsNullOrWhiteSpace(line) && !line.StartsWith("#"))
                        {
                            int separatorIndex = line.IndexOf('=');
                            if (separatorIndex > 0)
                            {
                                string key = line.Substring(0, separatorIndex).Trim();
                                string value = line.Substring(separatorIndex + 1).Trim();
                                _envVariables[key] = value;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error or handle as needed
                System.Diagnostics.Debug.WriteLine($"Error loading .env file: {ex.Message}");
            }
        }

        public static string GetValue(string key)
        {
            if (_envVariables == null)
            {
                LoadEnvFile();
            }

            return _envVariables.ContainsKey(key) ? _envVariables[key] : null;
        }
    }
}