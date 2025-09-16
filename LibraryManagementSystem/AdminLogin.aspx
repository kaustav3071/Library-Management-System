<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="LibraryManagementSystem.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | Library System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="Content/auth-layout-fixed.css" />
    <style>
        .auth-branding {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
        }
        
        .admin-badge {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            border: 1px solid rgba(239, 68, 68, 0.3);
            margin-bottom: 1rem;
            display: inline-block;
        }
        
        .security-features {
            margin-top: 2rem;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
        }
        
        .security-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        
        .security-item:last-child {
            margin-bottom: 0;
        }
        
        .security-item i {
            color: #10b981;
            font-size: 1rem;
        }
    </style>
</head>
<body class="auth-body">
    <form id="form1" runat="server">
        <div class="auth-wrapper">
            <!-- Left Side - Admin Branding -->
            <div class="auth-branding">
                <div class="branding-content">
                    <div class="brand-logo">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="admin-badge">
                        <i class="fas fa-crown"></i> Administrator Access
                    </div>
                    <h1 class="brand-title">Admin Portal</h1>
                    <p class="brand-subtitle">Secure administrative access to the Library System</p>
                    
                    <div class="security-features">
                        <h3 style="color: white; font-size: 1.1rem; margin-bottom: 1rem;">
                            <i class="fas fa-lock"></i> Security Features
                        </h3>
                        <div class="security-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Two-Factor Authentication</span>
                        </div>
                        <div class="security-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Encrypted Data Transmission</span>
                        </div>
                        <div class="security-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Activity Logging</span>
                        </div>
                        <div class="security-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Session Management</span>
                        </div>
                    </div>
                </div>
                <div class="auth-pattern"></div>
            </div>

            <!-- Right Side - Login Form -->
            <div class="auth-form-section">
                <div class="auth-container">
                    <div class="auth-header">
                        <h2 class="auth-title">Administrator Login</h2>
                        <p class="auth-description">Enter your credentials to access the admin panel</p>
                    </div>

                    <div class="auth-form-wrapper">
                        <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger modern-alert" Visible="false">
                            <i class="fas fa-exclamation-circle"></i>
                            <div class="alert-content">
                                <strong>Access Denied!</strong>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="form-group">
                            <label for="txtEmail" class="form-label">
                                <i class="fas fa-user-shield"></i>
                                Administrator Email
                            </label>
                            <div class="input-wrapper">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control modern-input" 
                                    TextMode="Email" placeholder="Enter your admin email" />
                                <div class="input-focus-border"></div>
                            </div>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Administrator email is required" CssClass="field-validation-error" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" 
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                ErrorMessage="Please enter a valid email address" CssClass="field-validation-error" Display="Dynamic" />
                        </div>

                        <div class="form-group">
                            <label for="txtPassword" class="form-label">
                                <i class="fas fa-key"></i>
                                Administrator Password
                            </label>
                            <div class="input-wrapper">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control modern-input" 
                                    TextMode="Password" placeholder="Enter your admin password" />
                                <div class="input-focus-border"></div>
                            </div>
                            <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" 
                                ErrorMessage="Administrator password is required" CssClass="field-validation-error" Display="Dynamic" />
                        </div>

                        <div class="form-options">
                            <div class="remember-me">
                                <input type="checkbox" id="rememberAdmin" class="custom-checkbox" />
                                <label for="rememberAdmin">Keep me signed in on this device</label>
                            </div>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Access Admin Panel" OnClick="btnLogin_Click" 
                            CssClass="btn btn-primary-modern btn-block" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);" />

                        <div class="auth-divider">
                            <span>or</span>
                        </div>

                        <div class="alternative-actions">
                            <a href="UserLogin.aspx" class="btn btn-outline-modern">
                                <i class="fas fa-user"></i>
                                User Login
                            </a>
                        </div>

                        <div class="auth-footer">
                            <div class="footer-links">
                                <a href="Welcome.aspx" class="back-home">
                                    <i class="fas fa-home"></i>
                                    Back to Home
                                </a>
                            </div>
                            
                            <div style="margin-top: 1.5rem; padding: 1rem; background: #f8fafc; border-radius: 8px; text-align: center;">
                                <small style="color: #64748b;">
                                    <i class="fas fa-info-circle"></i>
                                    Only authorized administrators can access this area.<br/>
                                    All login attempts are monitored and logged.
                                </small>
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

            // Add security warning for admin login
            const adminBtn = document.querySelector('.btn-primary-modern');
            if (adminBtn) {
                adminBtn.addEventListener('click', function(e) {
                    // Add loading state
                    this.classList.add('loading');
                    this.textContent = 'Authenticating...';
                });
            }
        });
    </script>
</body>
</html>