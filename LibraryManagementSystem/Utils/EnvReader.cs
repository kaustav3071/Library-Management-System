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
            // Initial attempt; may run before HttpContext is available
            LoadEnvFile();
        }

        private static string GetEnvFilePath()
        {
            try
            {
                if (HttpContext.Current != null && HttpContext.Current.Server != null)
                {
                    // Map to site root and append .env
                    string root = HttpContext.Current.Server.MapPath("~/");
                    return Path.Combine(root ?? string.Empty, ".env");
                }
            }
            catch
            {
                // ignore and fall back
            }

            // Fallback for contexts where HttpContext is not available
            try
            {
                string baseDir = AppDomain.CurrentDomain.BaseDirectory;
                return Path.Combine(baseDir ?? string.Empty, ".env");
            }
            catch
            {
                return ".env"; // last resort
            }
        }

        private static void LoadEnvFile()
        {
            // Case-insensitive keys for convenience
            _envVariables = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            
            try
            {
                string envPath = GetEnvFilePath();
                if (!string.IsNullOrEmpty(envPath) && File.Exists(envPath))
                {
                    string[] lines = File.ReadAllLines(envPath);
                    foreach (string rawLine in lines)
                    {
                        string line = rawLine?.Trim();
                        if (string.IsNullOrWhiteSpace(line) || line.StartsWith("#"))
                            continue;

                        int separatorIndex = line.IndexOf('=');
                        if (separatorIndex > 0)
                        {
                            string key = line.Substring(0, separatorIndex).Trim();
                            string value = line.Substring(separatorIndex + 1).Trim();

                            // Remove optional surrounding quotes
                            if (value.Length >= 2 && ((value.StartsWith("\"") && value.EndsWith("\"")) || (value.StartsWith("'") && value.EndsWith("'"))))
                            {
                                value = value.Substring(1, value.Length - 2);
                            }

                            if (!string.IsNullOrEmpty(key))
                            {
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
            if (string.IsNullOrEmpty(key))
                return null;

            // Ensure variables are loaded in a real request context (static ctor may have run too early)
            if (_envVariables == null || _envVariables.Count == 0)
            {
                LoadEnvFile();
            }

            string value;
            if (_envVariables != null && _envVariables.TryGetValue(key, out value))
            {
                return value;
            }

            // Fallback to OS environment variables
            try
            {
                return Environment.GetEnvironmentVariable(key);
            }
            catch
            {
                return null;
            }
        }
    }
}