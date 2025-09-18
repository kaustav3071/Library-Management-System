<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="LibraryManagementSystem.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrative Console | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Secure administrative access to the Library Management System" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            /* Admin Color Scheme - Dark & Professional */
            --admin-primary: #1a1a2e;
            --admin-secondary: #16213e;
            --admin-accent: #0f3460;
            --admin-highlight: #e94560;
            --admin-success: #00d4aa;
            --admin-warning: #ff9f00;
            --admin-danger: #ff5757;
            --admin-light: #f5f7fa;
            --admin-dark: #0a0e1a;
            --admin-text: #ffffff;
            --admin-text-muted: #8892b0;
            
            /* Admin Gradients */
            --admin-gradient-primary: linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
            --admin-gradient-accent: linear-gradient(135deg, #e94560 0%, #ff5757 100%);
            --admin-gradient-success: linear-gradient(135deg, #00d4aa 0%, #02c39a 100%);
            --admin-gradient-dark: linear-gradient(135deg, #0a0e1a 0%, #1a1a2e 100%);
            
            /* Shadows */
            --admin-shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.3);
            --admin-shadow-md: 0 4px 8px rgba(0, 0, 0, 0.4);
            --admin-shadow-lg: 0 8px 16px rgba(0, 0, 0, 0.5);
            --admin-shadow-xl: 0 16px 32px rgba(0, 0, 0, 0.6);
            
            /* Typography */
            --font-primary: 'Inter', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
            --font-weight-medium: 500;
            --font-weight-semibold: 600;
            --font-weight-bold: 700;
            
            /* Spacing */
            --spacing-sm: 0.5rem;
            --spacing-md: 1rem;
            --spacing-lg: 1.5rem;
            --spacing-xl: 2rem;
            --spacing-xxl: 3rem;
            
            /* Border Radius */
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-primary);
            background: var(--admin-gradient-dark);
            min-height: 100vh;
            color: var(--admin-text);
            overflow-x: hidden;
        }

        .admin-auth-wrapper {
            display: flex;
            min-height: 100vh;
            width: 100%;
            align-items: stretch;
        }

        /* Left Side - Admin Branding with Security Theme */
        .admin-branding {
            flex: 1;
            background: var(--admin-gradient-primary);
            color: var(--admin-text);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--spacing-xxl);
            position: relative;
            overflow: hidden;
        }

        .admin-branding::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(233, 69, 96, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(0, 212, 170, 0.1) 0%, transparent 50%),
                linear-gradient(45deg, transparent 30%, rgba(255, 255, 255, 0.02) 50%, transparent 70%);
            animation: adminFloat 10s ease-in-out infinite;
        }

        @keyframes adminFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.7; }
            25% { transform: translateY(-10px) rotate(1deg); opacity: 0.9; }
            50% { transform: translateY(-20px) rotate(-1deg); opacity: 1; }
            75% { transform: translateY(-10px) rotate(0.5deg); opacity: 0.9; }
        }

        .admin-branding-content {
            text-align: center;
            max-width: 450px;
            position: relative;
            z-index: 2;
        }

        .admin-shield-logo {
            width: 120px;
            height: 120px;
            background: var(--admin-gradient-accent);
            color: var(--admin-text);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            margin: 0 auto var(--spacing-xl);
            box-shadow: var(--admin-shadow-xl);
            border: 3px solid rgba(255, 255, 255, 0.1);
            position: relative;
        }

        .admin-shield-logo::before {
            content: '';
            position: absolute;
            top: -5px;
            left: -5px;
            right: -5px;
            bottom: -5px;
            border-radius: 50%;
            background: conic-gradient(from 0deg, var(--admin-highlight), var(--admin-success), var(--admin-highlight));
            z-index: -1;
            animation: rotate 3s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .admin-security-badge {
            background: var(--admin-gradient-success);
            color: var(--admin-dark);
            padding: var(--spacing-sm) var(--spacing-lg);
            border-radius: var(--radius-xl);
            font-weight: var(--font-weight-bold);
            font-size: 0.85rem;
            margin-bottom: var(--spacing-xl);
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-sm);
            box-shadow: var(--admin-shadow-md);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .admin-main-title {
            font-size: 2.8rem;
            font-weight: var(--font-weight-bold);
            margin-bottom: var(--spacing-md);
            line-height: 1.1;
            background: linear-gradient(135deg, var(--admin-text) 0%, var(--admin-success) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .admin-subtitle {
            font-size: 1.1rem;
            color: var(--admin-text-muted);
            margin-bottom: var(--spacing-xxl);
            line-height: 1.6;
        }

        .admin-security-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-lg);
            background: rgba(255, 255, 255, 0.05);
            padding: var(--spacing-xl);
            border-radius: var(--radius-lg);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .security-feature {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-md);
            background: rgba(0, 212, 170, 0.1);
            border-radius: var(--radius-md);
            border-left: 3px solid var(--admin-success);
        }

        .security-feature i {
            color: var(--admin-success);
            font-size: 1.2rem;
        }

        .security-feature span {
            font-size: 0.9rem;
            font-weight: var(--font-weight-medium);
        }

        /* Right Side - Admin Login Form */
        .admin-form-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--spacing-xxl);
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            position: relative;
        }

        .admin-form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23e2e8f0" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            opacity: 0.5;
        }

        .admin-login-container {
            width: 100%;
            max-width: 480px;
            position: relative;
            z-index: 2;
        }

        .admin-form-header {
            text-align: center;
            margin-bottom: var(--spacing-xxl);
        }

        .admin-form-logo {
            width: 80px;
            height: 80px;
            background: var(--admin-gradient-accent);
            color: white;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto var(--spacing-lg);
            box-shadow: var(--admin-shadow-lg);
            border: 2px solid rgba(233, 69, 96, 0.3);
        }

        .admin-form-title {
            font-size: 2.2rem;
            font-weight: var(--font-weight-bold);
            color: var(--admin-dark);
            margin-bottom: var(--spacing-md);
        }

        .admin-form-description {
            font-size: 1rem;
            color: #64748b;
            line-height: 1.6;
        }

        /* Admin Form Styles */
        .admin-login-form {
            background: white;
            padding: var(--spacing-xxl);
            border-radius: var(--radius-xl);
            box-shadow: var(--admin-shadow-xl);
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        .admin-form-group {
            margin-bottom: var(--spacing-xl);
        }

        .admin-form-label {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            font-weight: var(--font-weight-semibold);
            color: var(--admin-dark);
            font-size: 0.95rem;
            margin-bottom: var(--spacing-sm);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .admin-form-label i {
            color: var(--admin-highlight);
        }

        .admin-input-wrapper {
            position: relative;
        }

        .admin-form-input {
            width: 100%;
            padding: var(--spacing-lg);
            border: 2px solid #e2e8f0;
            border-radius: var(--radius-lg);
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8fafc;
            color: var(--admin-dark);
        }

        .admin-form-input:focus {
            outline: none;
            border-color: var(--admin-highlight);
            background: white;
            box-shadow: 0 0 0 4px rgba(233, 69, 96, 0.1);
            transform: translateY(-2px);
        }

        .admin-form-input::placeholder {
            color: #94a3b8;
        }

        .admin-submit-btn {
            width: 100%;
            padding: var(--spacing-lg) var(--spacing-xl);
            background: var(--admin-gradient-accent);
            color: white;
            border: none;
            border-radius: var(--radius-lg);
            font-size: 1.1rem;
            font-weight: var(--font-weight-bold);
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--admin-shadow-md);
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .admin-submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .admin-submit-btn:hover::before {
            left: 100%;
        }

        .admin-submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: var(--admin-shadow-lg);
        }

        .admin-submit-btn:active {
            transform: translateY(-1px);
        }

        /* Alert Styles */
        .admin-alert-container {
            margin-bottom: var(--spacing-lg);
        }

        .admin-alert {
            padding: var(--spacing-lg);
            border-radius: var(--radius-lg);
            display: flex;
            align-items: flex-start;
            gap: var(--spacing-md);
            border: none;
            background: var(--admin-gradient-accent);
            color: white;
            box-shadow: var(--admin-shadow-md);
        }

        .admin-alert i {
            font-size: 1.2rem;
            margin-top: 2px;
        }

        /* Validation Errors */
        .admin-validation-error {
            color: var(--admin-danger);
            font-size: 0.875rem;
            margin-top: var(--spacing-sm);
            display: block;
            font-weight: var(--font-weight-medium);
        }

        /* Alternative Actions */
        .admin-alt-actions {
            text-align: center;
            margin-top: var(--spacing-xl);
            padding-top: var(--spacing-lg);
            border-top: 2px solid #e2e8f0;
        }

        .admin-alt-link {
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-sm);
            color: var(--admin-highlight);
            text-decoration: none;
            font-weight: var(--font-weight-semibold);
            margin: 0 var(--spacing-lg);
            transition: all 0.2s ease;
            padding: var(--spacing-sm) var(--spacing-md);
            border-radius: var(--radius-md);
        }

        .admin-alt-link:hover {
            color: var(--admin-danger);
            text-decoration: none;
            transform: translateY(-2px);
            background: rgba(233, 69, 96, 0.1);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .admin-auth-wrapper {
                flex-direction: column;
            }
            
            .admin-branding {
                min-height: 45vh;
                padding: var(--spacing-xl);
            }
            
            .admin-main-title {
                font-size: 2.2rem;
            }

            .admin-security-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .admin-branding {
                min-height: 35vh;
                padding: var(--spacing-lg);
            }
            
            .admin-form-section {
                padding: var(--spacing-lg);
            }
            
            .admin-main-title {
                font-size: 1.9rem;
            }
            
            .admin-form-title {
                font-size: 1.8rem;
            }

            .admin-login-form {
                padding: var(--spacing-xl);
            }
        }

        @media (max-width: 576px) {
            .admin-branding,
            .admin-form-section {
                padding: var(--spacing-md);
            }
            
            .admin-main-title {
                font-size: 1.6rem;
            }
            
            .admin-login-form {
                padding: var(--spacing-lg);
            }
            
            .admin-form-input,
            .admin-submit-btn {
                padding: var(--spacing-md) var(--spacing-lg);
            }
        }

        /* Loading Animation */
        .admin-loading {
            opacity: 0.8;
            pointer-events: none;
        }

        .admin-loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 24px;
            height: 24px;
            margin: -12px 0 0 -12px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: adminSpin 1s linear infinite;
        }

        @keyframes adminSpin {
            to { transform: rotate(360deg); }
        }

        /* Security indicator */
        .security-indicator {
            position: absolute;
            top: var(--spacing-lg);
            right: var(--spacing-lg);
            background: var(--admin-gradient-success);
            color: var(--admin-dark);
            padding: var(--spacing-sm) var(--spacing-md);
            border-radius: var(--radius-xl);
            font-size: 0.8rem;
            font-weight: var(--font-weight-bold);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            box-shadow: var(--admin-shadow-sm);
        }

        .security-indicator i {
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-auth-wrapper">
            <!-- Security Indicator -->
            <div class="security-indicator">
                <i class="fas fa-shield-check"></i>
                <span>SECURE CONNECTION</span>
            </div>

            <!-- Left Side - Admin Branding -->
            <div class="admin-branding">
                <div class="admin-branding-content">
                    <div class="admin-shield-logo">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <div class="admin-security-badge">
                        <i class="fas fa-crown"></i>
                        <span>Administrator Access</span>
                    </div>
                    <h1 class="admin-main-title">Command Center</h1>
                    <p class="admin-subtitle">Secure administrative access to the Library Management System with advanced security protocols and monitoring.</p>
                    
                    <div class="admin-security-grid">
                        <div class="security-feature">
                            <i class="fas fa-lock"></i>
                            <span>Encrypted Sessions</span>
                        </div>
                        <div class="security-feature">
                            <i class="fas fa-eye"></i>
                            <span>Activity Monitoring</span>
                        </div>
                        <div class="security-feature">
                            <i class="fas fa-shield-virus"></i>
                            <span>Threat Protection</span>
                        </div>
                        <div class="security-feature">
                            <i class="fas fa-user-cog"></i>
                            <span>Access Control</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side - Admin Login Form -->
            <div class="admin-form-section">
                <div class="admin-login-container">
                    <div class="admin-form-header">
                        <div class="admin-form-logo">
                            <i class="fas fa-terminal"></i>
                        </div>
                        <h2 class="admin-form-title">System Login</h2>
                        <p class="admin-form-description">Enter your administrative credentials to access the command center</p>
                    </div>

                    <div class="admin-login-form">
                        <asp:Panel ID="pnlError" runat="server" CssClass="admin-alert-container" Visible="false">
                            <div class="admin-alert">
                                <i class="fas fa-exclamation-triangle"></i>
                                <div>
                                    <strong>Access Denied</strong><br />
                                    <asp:Label ID="lblError" runat="server"></asp:Label>
                                </div>
                            </div>
                        </asp:Panel>

                        <div class="admin-form-group">
                            <label for="txtEmail" class="admin-form-label">
                                <i class="fas fa-id-badge"></i>
                                Administrator ID
                            </label>
                            <div class="admin-input-wrapper">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="admin-form-input" 
                                    TextMode="Email" placeholder="Enter your administrator email" />
                            </div>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" 
                                ErrorMessage="Administrator ID is required" CssClass="admin-validation-error" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" 
                                ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                ErrorMessage="Please enter a valid administrator email" CssClass="admin-validation-error" Display="Dynamic" />
                        </div>

                        <div class="admin-form-group">
                            <label for="txtPassword" class="admin-form-label">
                                <i class="fas fa-key"></i>
                                Security Passkey
                            </label>
                            <div class="admin-input-wrapper">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="admin-form-input" 
                                    TextMode="Password" placeholder="Enter your secure passkey" />
                            </div>
                            <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" 
                                ErrorMessage="Security passkey is required" CssClass="admin-validation-error" Display="Dynamic" />
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Access Command Center" OnClick="btnLogin_Click" 
                            CssClass="admin-submit-btn" UseSubmitBehavior="true" />

                        <div class="admin-alt-actions">
                            <a href="UserLogin.aspx" class="admin-alt-link">
                                <i class="fas fa-user"></i>
                                <span>Member Portal</span>
                            </a>
                            <a href="Welcome.aspx" class="admin-alt-link">
                                <i class="fas fa-home"></i>
                                <span>Exit to Home</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus first input
            const firstInput = document.querySelector('.admin-form-input');
            if (firstInput && !firstInput.value) {
                setTimeout(() => firstInput.focus(), 200);
            }

            // Form submission with admin loading
            const form = document.getElementById('form1');
            const loginBtn = document.querySelector('.admin-submit-btn');
            
            if (form && loginBtn) {
                form.addEventListener('submit', function(e) {
                    var isValid = true;
                    if (typeof Page_ClientValidate === 'function') {
                        isValid = Page_ClientValidate();
                    }
                    
                    if (isValid) {
                        loginBtn.classList.add('admin-loading');
                        loginBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> AUTHENTICATING...';
                    }
                });
            }

            // Admin-style input interactions
            const inputs = document.querySelectorAll('.admin-form-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            });

            // Security animation
            const securityIndicator = document.querySelector('.security-indicator');
            if (securityIndicator) {
                setInterval(() => {
                    securityIndicator.style.transform = 'scale(1.05)';
                    setTimeout(() => {
                        securityIndicator.style.transform = 'scale(1)';
                    }, 200);
                }, 3000);
            }
        });
    </script>
</body>
</html>