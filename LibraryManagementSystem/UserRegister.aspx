<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" Inherits="LibraryManagementSystem.UserRegister" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Registration | Library System</title>
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
                    <h1 class="brand-title">Join Our Library</h1>
                    <p class="brand-subtitle">Create your account and start your learning journey</p>
                    <div class="brand-features">
                        <div class="feature-item">
                            <i class="fas fa-user-plus"></i>
                            <span>Easy Registration</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-book-reader"></i>
                            <span>Unlimited Book Access</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-history"></i>
                            <span>Track Reading History</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-bell"></i>
                            <span>Due Date Reminders</span>
                        </div>
                    </div>
                </div>
                <div class="auth-pattern"></div>
            </div>

            <!-- Right Side - Registration Form -->
            <div class="auth-form-section">
                <div class="auth-container">
                    <div class="auth-header">
                        <h2 class="auth-title">Create Account</h2>
                        <p class="auth-description">Join our community of book lovers</p>
                    </div>

                    <div class="auth-form-wrapper">
                        <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger modern-alert" Visible="false">
                            <i class="fas fa-exclamation-circle"></i>
                            <div class="alert-content">
                                <strong>Error!</strong>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlSuccess" runat="server" CssClass="alert alert-success modern-alert" Visible="false">
                            <i class="fas fa-check-circle"></i>
                            <div class="alert-content">
                                <strong>Success!</strong>
                                <asp:Label ID="lblSuccess" runat="server"></asp:Label>
                            </div>
                        </asp:Panel>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtName" class="form-label">
                                    <i class="fas fa-user"></i>
                                    Full Name
                                </label>
                                <div class="input-wrapper">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control modern-input" 
                                        placeholder="Enter your full name" />
                                    <div class="input-focus-border"></div>
                                </div>
                                <asp:RequiredFieldValidator ID="reqName" runat="server" ControlToValidate="txtName" 
                                    ErrorMessage="Full name is required" CssClass="field-validation-error" Display="Dynamic" />
                            </div>
                        </div>

                        <div class="form-row">
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
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtPhone" class="form-label">
                                    <i class="fas fa-phone"></i>
                                    Phone Number
                                </label>
                                <div class="input-wrapper">
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control modern-input" 
                                        placeholder="Enter your phone number" />
                                    <div class="input-focus-border"></div>
                                </div>
                                <asp:RequiredFieldValidator ID="reqPhone" runat="server" ControlToValidate="txtPhone" 
                                    ErrorMessage="Phone number is required" CssClass="field-validation-error" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="regexPhone" runat="server" ControlToValidate="txtPhone" 
                                    ValidationExpression="^[\+]?[\d\s\-\(\)]{6,30}$" 
                                    ErrorMessage="Please enter a valid phone number" CssClass="field-validation-error" Display="Dynamic" />
                            </div>
                        </div>

                        <div class="form-row form-row-half">
                            <div class="form-group">
                                <label for="txtPassword" class="form-label">
                                    <i class="fas fa-lock"></i>
                                    Password
                                </label>
                                <div class="input-wrapper">
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control modern-input" 
                                        TextMode="Password" placeholder="Create a strong password" />
                                    <div class="input-focus-border"></div>
                                </div>
                                <div class="password-strength" id="passwordStrength" style="display: none;">
                                    <div class="strength-indicator">
                                        <div class="strength-bar"></div>
                                    </div>
                                    <span class="strength-text"></span>
                                </div>
                                <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" 
                                    ErrorMessage="Password is required" CssClass="field-validation-error" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="regexPassword" runat="server" ControlToValidate="txtPassword" 
                                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" 
                                    ErrorMessage="Password must be at least 8 characters with uppercase, lowercase, number and special character" 
                                    CssClass="field-validation-error" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txtConfirmPassword" class="form-label">
                                    <i class="fas fa-lock"></i>
                                    Confirm Password
                                </label>
                                <div class="input-wrapper">
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control modern-input" 
                                        TextMode="Password" placeholder="Confirm your password" />
                                    <div class="input-focus-border"></div>
                                </div>
                                <asp:RequiredFieldValidator ID="reqConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                                    ErrorMessage="Please confirm your password" CssClass="field-validation-error" Display="Dynamic" />
                                <asp:CompareValidator ID="comparePassword" runat="server" ControlToValidate="txtConfirmPassword" 
                                    ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" 
                                    CssClass="field-validation-error" Display="Dynamic" />
                            </div>
                        </div>

                        <div class="terms-agreement">
                            <div class="form-check">
                                <input type="checkbox" id="agreeTerms" class="custom-checkbox" required />
                                <label for="agreeTerms">
                                    I agree to the <a href="#" class="terms-link">Terms of Service</a> and <a href="#" class="terms-link">Privacy Policy</a>
                                </label>
                            </div>
                        </div>

                        <asp:Button ID="btnRegister" runat="server" Text="Create Account" OnClick="btnRegister_Click" 
                            CssClass="btn btn-primary-modern btn-block" />

                        <div class="auth-divider">
                            <span>or</span>
                        </div>

                        <div class="alternative-actions">
                            <a href="UserLogin.aspx" class="btn btn-outline-modern">
                                <i class="fas fa-sign-in-alt"></i>
                                Already have an account? Sign In
                            </a>
                        </div>

                        <div class="auth-footer">
                            <div class="footer-links">
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

            // Password strength indicator
            const passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            const strengthIndicator = document.getElementById('passwordStrength');
            
            if (passwordInput && strengthIndicator) {
                passwordInput.addEventListener('input', function() {
                    const password = this.value;
                    const strength = calculatePasswordStrength(password);
                    updatePasswordStrength(strength);
                });
            }

            function calculatePasswordStrength(password) {
                let score = 0;
                if (password.length >= 8) score++;
                if (/[a-z]/.test(password)) score++;
                if (/[A-Z]/.test(password)) score++;
                if (/\d/.test(password)) score++;
                if (/[@$!%*?&]/.test(password)) score++;
                
                return score;
            }

            function updatePasswordStrength(score) {
                const strengthIndicator = document.getElementById('passwordStrength');
                const strengthBar = strengthIndicator.querySelector('.strength-bar');
                const strengthText = strengthIndicator.querySelector('.strength-text');
                
                if (score === 0) {
                    strengthIndicator.style.display = 'none';
                    return;
                }
                
                strengthIndicator.style.display = 'block';
                
                const strengthLevels = [
                    { class: 'weak', text: 'Weak', width: '20%' },
                    { class: 'fair', text: 'Fair', width: '40%' },
                    { class: 'good', text: 'Good', width: '60%' },
                    { class: 'strong', text: 'Strong', width: '80%' },
                    { class: 'very-strong', text: 'Very Strong', width: '100%' }
                ];
                
                const level = strengthLevels[score - 1] || strengthLevels[0];
                strengthBar.className = `strength-bar ${level.class}`;
                strengthBar.style.width = level.width;
                strengthText.textContent = level.text;
            }
        });
    </script>
</body>
</html>