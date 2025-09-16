<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="LibraryManagementSystem.UserLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login | Library System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="Content/auth-layout-fixed.css" />
</head>
<body class="auth-body">
    <form id="form1" runat="server">
        <div class="auth-wrapper">
            <!-- Left Side - Branding -->
            <div class="auth-branding">
                <div class="branding-content">
                    <div class="brand-logo">
                        <i class="fas fa-book-open"></i>
                    </div>
                    <h1 class="brand-title">Library System</h1>
                    <p class="brand-subtitle">Your gateway to knowledge and learning</p>
                    <div class="brand-features">
                        <div class="feature-item">
                            <i class="fas fa-books"></i>
                            <span>Extensive Book Collection</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-clock"></i>
                            <span>24/7 Online Access</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-user-friends"></i>
                            <span>Community of Readers</span>
                        </div>
                    </div>
                </div>
                <div class="auth-pattern"></div>
            </div>

            <!-- Right Side - Login Form -->
            <div class="auth-form-section">
                <div class="auth-container">
                    <div class="auth-header">
                        <h2 class="auth-title">Welcome Back</h2>
                        <p class="auth-description">Sign in to access your library account</p>
                    </div>

                    <div class="auth-form-wrapper">
                        <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger modern-alert" Visible="false">
                            <i class="fas fa-exclamation-circle"></i>
                            <div class="alert-content">
                                <strong>Error!</strong>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="form-group">
                            <label for="txtEmail" class="form-label">
                                <i class="fas fa-envelope"></i>
                                Email Address
                            </label>
                            <div class="input-wrapper">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control modern-input" 
                                    TextMode="Email" placeholder="Enter your email address" />
                                <div class="input-focus-border"></div>
                            </div>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Email address is required" CssClass="field-validation-error" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" 
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                ErrorMessage="Please enter a valid email address" CssClass="field-validation-error" Display="Dynamic" />
                        </div>

                        <div class="form-group">
                            <label for="txtPassword" class="form-label">
                                <i class="fas fa-lock"></i>
                                Password
                            </label>
                            <div class="input-wrapper">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control modern-input" 
                                    TextMode="Password" placeholder="Enter your password" />
                                <div class="input-focus-border"></div>
                            </div>
                            <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" 
                                ErrorMessage="Password is required" CssClass="field-validation-error" Display="Dynamic" />
                        </div>

                        <div class="form-options">
                            <div class="remember-me">
                                <input type="checkbox" id="rememberMe" class="custom-checkbox" />
                                <label for="rememberMe">Remember me</label>
                            </div>
                            <a href="#" class="forgot-password">Forgot password?</a>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" 
                            CssClass="btn btn-primary-modern btn-block" />

                        <div class="auth-divider">
                            <span>or</span>
                        </div>

                        <div class="alternative-actions">
                            <a href="UserRegister.aspx" class="btn btn-outline-modern">
                                <i class="fas fa-user-plus"></i>
                                Create New Account
                            </a>
                        </div>

                        <div class="auth-footer">
                            <div class="footer-links">
                                <a href="AdminLogin.aspx" class="admin-access">
                                    <i class="fas fa-shield-alt"></i>
                                    Admin Access
                                </a>
                                <a href="Welcome.aspx" class="back-home">
                                    <i class="fas fa-home"></i>
                                    Back to Home
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Input focus effects
            const inputs = document.querySelectorAll('.modern-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    if (!this.value) {
                        this.parentElement.classList.remove('focused');
                    }
                });
                
                // Check if input has value on load
                if (input.value) {
                    input.parentElement.classList.add('focused');
                }
            });
        });
    </script>
</body>
</html>