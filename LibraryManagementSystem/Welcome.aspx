<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="LibraryManagementSystem.Welcome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Management System | Professional Digital Library Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Professional Library Management System for efficient book and member management" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/welcome-professional.css" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- Professional Header -->
        <header class="professional-header">
            <div class="container">
                <div class="header-content">
                    <div class="brand-section">
                        <div class="brand-logo">
                            <i class="fas fa-university"></i>
                        </div>
                        <div class="brand-info">
                            <h1 class="brand-title">Digital Library</h1>
                            <p class="brand-subtitle">Management System</p>
                        </div>
                    </div>
                    
                    <nav class="main-navigation">
                        <asp:Panel ID="pnlUserAuth" runat="server" CssClass="auth-section">
                            <a href="UserLogin.aspx" class="nav-btn primary-btn">
                                <i class="fas fa-sign-in-alt"></i>
                                <span>Member Login</span>
                            </a>
                            <a href="UserRegister.aspx" class="nav-btn secondary-btn">
                                <i class="fas fa-user-plus"></i>
                                <span>Register</span>
                            </a>
                        </asp:Panel>
                        
                        <asp:Panel ID="pnlUserLoggedIn" runat="server" CssClass="user-panel" Visible="false">
                            <div class="user-info">
                                <div class="user-avatar">
                                    <i class="fas fa-user-circle"></i>
                                </div>
                                <div class="user-details">
                                    <span class="user-greeting">Welcome back</span>
                                    <span class="user-name"><asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                                </div>
                            </div>
                            <div class="user-menu">
                                <a href="UserBorrowings.aspx" class="nav-btn dashboard-btn">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>Dashboard</span>
                                </a>
                                <asp:Button ID="btnUserLogout" runat="server" Text="Sign Out" OnClick="btnUserLogout_Click" 
                                    CssClass="nav-btn logout-btn" CausesValidation="false" />
                            </div>
                        </asp:Panel>

                        <div class="admin-access">
                            <a href="AdminLogin.aspx" class="admin-link">
                                <i class="fas fa-cog"></i>
                                <span>Admin Console</span>
                            </a>
                        </div>
                    </nav>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content">
            <div class="container">
                <!-- Hero Section -->
                <section class="hero-section">
                    <div class="hero-content">
                        <h2 class="hero-title">Advanced Library Management Solutions</h2>
                        <p class="hero-description">
                            Streamline your library operations with our comprehensive digital management platform. 
                            Efficiently manage collections, track borrowings, and serve your community with modern tools.
                        </p>
                        <div class="hero-actions">
                            <a href="BookCatalog.aspx" class="cta-btn primary-cta">
                                <i class="fas fa-search"></i>
                                <span>Browse Catalog</span>
                            </a>
                            <asp:HyperLink ID="lnkUserAccount" runat="server" NavigateUrl="UserLogin.aspx" CssClass="cta-btn secondary-cta">
                                <i class="fas fa-user"></i>
                                <span id="accountLinkText" runat="server">Access Account</span>
                            </asp:HyperLink>
                        </div>
                    </div>
                </section>

                <!-- Statistics Section -->
                <section class="statistics-section">
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon books-stat">
                                <i class="fas fa-book-open"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">1,250</div>
                                <div class="stat-label">Books in Collection</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon members-stat">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">350</div>
                                <div class="stat-label">Active Members</div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon loans-stat">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">127</div>
                                <div class="stat-label">Current Loans</div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Services Section -->
                <section class="services-section">
                    <div class="section-header">
                        <h3 class="section-title">Library Services</h3>
                        <p class="section-subtitle">Access our comprehensive range of digital library services</p>
                    </div>
                    
                    <div class="services-grid">
                        <div class="service-card">
                            <div class="service-header">
                                <div class="service-icon catalog-icon">
                                    <i class="fas fa-books"></i>
                                </div>
                                <h4 class="service-title">Digital Catalog</h4>
                            </div>
                            <p class="service-description">
                                Explore our extensive digital catalog with advanced search capabilities, 
                                detailed book information, and availability status.
                            </p>
                            <a href="BookCatalog.aspx" class="service-link">
                                <span>Explore Catalog</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>

                        <div class="service-card">
                            <div class="service-header">
                                <div class="service-icon account-icon">
                                    <i class="fas fa-user-cog"></i>
                                </div>
                                <h4 class="service-title">Member Portal</h4>
                            </div>
                            <p class="service-description">
                                Manage your library account, view borrowing history, track due dates, 
                                and access personalized recommendations.
                            </p>
                            <a href="UserLogin.aspx" class="service-link">
                                <span>Access Portal</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>

                        <div class="service-card">
                            <div class="service-header">
                                <div class="service-icon support-icon">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <h4 class="service-title">Library Support</h4>
                            </div>
                            <p class="service-description">
                                Get assistance with library services, borrowing policies, 
                                digital resources, and technical support.
                            </p>
                            <a href="#" class="service-link">
                                <span>Get Support</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </section>

                <!-- Admin Dashboard Section -->
                <asp:Panel ID="pnlAdminSection" runat="server" Visible="false">
                    <section class="admin-dashboard-section">
                        <div class="section-header">
                            <h3 class="section-title">
                                <i class="fas fa-shield-alt"></i>
                                Administrative Console
                            </h3>
                            <p class="section-subtitle">Comprehensive library management tools and analytics</p>
                        </div>
                        
                        <div class="admin-grid">
                            <a href="Books.aspx" class="admin-module">
                                <div class="module-header">
                                    <div class="module-icon books-module">
                                        <i class="fas fa-book"></i>
                                    </div>
                                    <h5 class="module-title">Collection Management</h5>
                                </div>
                                <p class="module-description">Add, edit, and organize library books and digital resources</p>
                                <div class="module-action">
                                    <span>Manage Collection</span>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>

                            <a href="Members.aspx" class="admin-module">
                                <div class="module-header">
                                    <div class="module-icon members-module">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <h5 class="module-title">Member Management</h5>
                                </div>
                                <p class="module-description">View, manage, and support registered library members</p>
                                <div class="module-action">
                                    <span>Manage Members</span>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>

                            <a href="Borrowings.aspx" class="admin-module">
                                <div class="module-header">
                                    <div class="module-icon transactions-module">
                                        <i class="fas fa-exchange-alt"></i>
                                    </div>
                                    <h5 class="module-title">Transaction Management</h5>
                                </div>
                                <p class="module-description">Monitor loans, returns, and borrowing analytics</p>
                                <div class="module-action">
                                    <span>View Transactions</span>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </div>
                    </section>
                </asp:Panel>
            </div>
        </main>

        <!-- Professional Footer -->
        <footer class="professional-footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-brand">
                        <div class="footer-logo">
                            <i class="fas fa-university"></i>
                        </div>
                        <div class="footer-info">
                            <h6>Digital Library Management</h6>
                            <p>Professional Solutions for Modern Libraries</p>
                        </div>
                    </div>
                    <div class="footer-links">
                        <div class="link-group">
                            <h6>Services</h6>
                            <ul>
                                <li><a href="BookCatalog.aspx">Catalog</a></li>
                                <li><a href="UserLogin.aspx">Member Portal</a></li>
                                <li><a href="#">Support</a></li>
                            </ul>
                        </div>
                        <div class="link-group">
                            <h6>Resources</h6>
                            <ul>
                                <li><a href="#">User Guide</a></li>
                                <li><a href="#">Policies</a></li>
                                <li><a href="#">FAQ</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; <%= DateTime.Now.Year %> Library Management System. All rights reserved.</p>
                    <p>Professional Digital Library Solutions</p>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>
