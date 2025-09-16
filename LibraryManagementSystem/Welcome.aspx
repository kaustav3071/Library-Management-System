<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="LibraryManagementSystem.Welcome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/welcome-modern.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- Auth Header -->
            <div class="auth-header-container fade-in">
                <asp:Panel ID="pnlUserAuth" runat="server" CssClass="user-auth-links">
                    <a href="UserLogin.aspx" class="auth-btn login-btn">
                        <i class="fas fa-sign-in-alt mr-2"></i>Sign In
                    </a>
                    <a href="UserRegister.aspx" class="auth-btn register-btn">
                        <i class="fas fa-user-plus mr-2"></i>Register
                    </a>
                </asp:Panel>
                
                <asp:Panel ID="pnlUserLoggedIn" runat="server" CssClass="user-logged-in" Visible="false">
                    <div class="user-welcome">
                        <i class="fas fa-user-circle mr-2"></i>
                        Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label>
                    </div>
                    <div class="user-actions">
                        <a href="UserBorrowings.aspx" class="auth-btn dashboard-btn">
                            <i class="fas fa-book-reader mr-2"></i>My Books
                        </a>
                        <asp:Button ID="btnUserLogout" runat="server" Text="Logout" OnClick="btnUserLogout_Click" 
                            CssClass="auth-btn logout-btn" CausesValidation="false" />
                    </div>
                </asp:Panel>

                <div class="admin-access">
                    <a href="AdminLogin.aspx" class="admin-access-link">
                        <i class="fas fa-shield-alt mr-2"></i>Admin Panel
                    </a>
                </div>
            </div>

            <div class="hero fade-in">
                <h1>Welcome to Library Management System</h1>
                <p>Discover, borrow, and manage books with our modern digital library platform</p>
            </div>

            <div class="stats-container fade-in">
                <div class="row">
                    <div class="col-md-4 stat-item">
                        <div class="stat-number">1,250</div>
                        <div class="stat-label">Total Books</div>
                    </div>
                    <div class="col-md-4 stat-item">
                        <div class="stat-number">350</div>
                        <div class="stat-label">Active Members</div>
                    </div>
                    <div class="col-md-4 stat-item">
                        <div class="stat-number">127</div>
                        <div class="stat-label">Current Loans</div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card feature-card fade-in">
                        <div class="card-body text-center">
                            <div class="card-icon books-icon mx-auto">
                                <i class="fas fa-book"></i>
                            </div>
                            <h3 class="card-title">Browse Books</h3>
                            <p class="card-description">Explore our comprehensive collection of books across various genres and discover your next great read.</p>
                            <a href="BookCatalog.aspx" class="btn btn-modern btn-books">Browse Catalog</a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card feature-card fade-in">
                        <div class="card-body text-center">
                            <div class="card-icon members-icon mx-auto">
                                <i class="fas fa-user-circle"></i>
                            </div>
                            <h3 class="card-title">My Account</h3>
                            <p class="card-description">Access your personal library account to view borrowed books, history, and manage your profile.</p>
                            <asp:HyperLink ID="lnkUserAccount" runat="server" NavigateUrl="UserLogin.aspx" CssClass="btn btn-modern btn-members">
                                <span id="accountLinkText" runat="server">Sign In</span>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card feature-card fade-in">
                        <div class="card-body text-center">
                            <div class="card-icon borrowings-icon mx-auto">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <h3 class="card-title">Library Services</h3>
                            <p class="card-description">Learn about our borrowing policies, opening hours, and available library services.</p>
                            <a href="#" class="btn btn-modern btn-borrowings">Learn More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Admin Section (only visible to admin) -->
            <asp:Panel ID="pnlAdminSection" runat="server" Visible="false">
                <div class="admin-section fade-in">
                    <h3 class="section-title">
                        <i class="fas fa-shield-alt mr-2"></i>Admin Dashboard
                    </h3>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <a href="Books.aspx" class="admin-card">
                                <div class="admin-card-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <div class="admin-card-content">
                                    <h5>Manage Books</h5>
                                    <p>Add, edit, and manage library books</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <a href="Members.aspx" class="admin-card">
                                <div class="admin-card-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="admin-card-content">
                                    <h5>Manage Members</h5>
                                    <p>View and manage registered users</p>
                                </div>
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <a href="Borrowings.aspx" class="admin-card">
                                <div class="admin-card-icon">
                                    <i class="fas fa-exchange-alt"></i>
                                </div>
                                <div class="admin-card-content">
                                    <h5>Manage Borrowings</h5>
                                    <p>Track loans and returns</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <div class="footer text-center">
                <p class="mb-0">
                    &copy; <%= DateTime.Now.Year %> Library Management System - Connecting Readers with Knowledge
                </p>
            </div>
        </div>
    </form>
    <script src="Scripts/welcome-modern.js"></script>
</body>
</html>
