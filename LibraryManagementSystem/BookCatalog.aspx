<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCatalog.aspx.cs" Inherits="LibraryManagementSystem.BookCatalog" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Digital Catalog | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Browse and search our comprehensive digital book catalog" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/catalog-professional.css" />
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
                        <asp:Panel ID="pnlUserHeader" runat="server" CssClass="user-panel" Visible="false">
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
                                <asp:Button ID="btnLogout" runat="server" Text="Sign Out" OnClick="btnLogout_Click" 
                                    CssClass="nav-btn logout-btn" CausesValidation="false" />
                            </div>
                        </asp:Panel>
                        
                        <asp:Panel ID="pnlGuestHeader" runat="server" CssClass="auth-section">
                            <a href="UserLogin.aspx" class="nav-btn primary-btn">
                                <i class="fas fa-sign-in-alt"></i>
                                <span>Member Login</span>
                            </a>
                            <a href="UserRegister.aspx" class="nav-btn secondary-btn">
                                <i class="fas fa-user-plus"></i>
                                <span>Register</span>
                            </a>
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

        <!-- Breadcrumb Navigation -->
        <section class="breadcrumb-section">
            <div class="container">
                <nav class="breadcrumb-nav">
                    <a href="Welcome.aspx" class="breadcrumb-link">
                        <i class="fas fa-home"></i>
                        <span>Home</span>
                    </a>
                    <i class="fas fa-chevron-right breadcrumb-separator"></i>
                    <span class="breadcrumb-current">
                        <i class="fas fa-books"></i>
                        <span>Digital Catalog</span>
                    </span>
                </nav>
            </div>
        </section>

        <!-- Main Content -->
        <main class="main-content">
            <div class="container">
                <!-- Page Header -->
                <section class="page-header-section">
                    <div class="page-header-content">
                        <div class="header-info">
                            <h2 class="page-title">Digital Book Catalog</h2>
                            <p class="page-description">
                                Explore our comprehensive collection of books with advanced search capabilities 
                                and real-time availability status.
                            </p>
                        </div>
                        <div class="header-stats">
                            <div class="quick-stat">
                                <div class="stat-icon">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-label">Total Books</div>
                                    <div class="stat-value">1,250</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Search and Filter Section -->
                <section class="search-section">
                    <div class="search-container">
                        <div class="search-header">
                            <h3 class="search-title">
                                <i class="fas fa-search"></i>
                                Find Books
                            </h3>
                            <p class="search-subtitle">Search by title, author, ISBN, or keywords</p>
                        </div>
                        
                        <div class="search-form">
                            <div class="search-input-group">
                                <div class="search-input-container">
                                    <i class="fas fa-search search-icon"></i>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" 
                                        placeholder="Enter book title, author name, or ISBN..." />
                                </div>
                                <div class="search-actions">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" 
                                        CssClass="search-btn primary-search" CausesValidation="false" />
                                    <asp:Button ID="btnShowAll" runat="server" Text="Show All" OnClick="btnShowAll_Click" 
                                        CssClass="search-btn secondary-search" CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Results Section -->
                <section class="results-section">
                    <div class="results-container">
                        <div class="results-header">
                            <h3 class="results-title">
                                <i class="fas fa-list-ul"></i>
                                Available Books
                            </h3>
                            
                            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                                <div class="alert-container">
                                    <div class="alert alert-professional">
                                        <i class="fas fa-info-circle"></i>
                                        <span><asp:Label ID="lblMessage" runat="server"></asp:Label></span>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>

                        <div class="table-container">
                            <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" 
                                CssClass="professional-table" EmptyDataText="No books found." 
                                OnRowCommand="gvBooks_RowCommand" OnRowDataBound="gvBooks_RowDataBound" DataKeyNames="Id">
                                <Columns>
                                    <asp:TemplateField HeaderText="Book Information" ItemStyle-Width="40%">
                                        <ItemTemplate>
                                            <div class="book-info">
                                                <div class="book-icon">
                                                    <i class="fas fa-book"></i>
                                                </div>
                                                <div class="book-details">
                                                    <h5 class="book-title"><%# Eval("Title") %></h5>
                                                    <p class="book-author">by <%# Eval("Author") %></p>
                                                    <span class="book-isbn">ISBN: <%# Eval("ISBN") %></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Availability Status" ItemStyle-Width="25%">
                                        <ItemTemplate>
                                            <div class="availability-container">
                                                <span class='<%# GetAvailabilityClass(Eval("Id")) %>'>
                                                    <i class='<%# GetAvailabilityIcon(Eval("Id")) %>'></i>
                                                    <span><%# GetAvailabilityText(Eval("Id")) %></span>
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Action" ItemStyle-Width="35%">
                                        <ItemTemplate>
                                            <div class="action-container">
                                                <asp:LinkButton ID="btnBorrowBook" runat="server" 
                                                    CssClass='<%# GetBorrowButtonClass(Eval("Id")) %>'
                                                    CommandName="BorrowBook" CommandArgument='<%# Eval("Id") %>'
                                                    Enabled='<%# CanBorrowBook(Eval("Id")) %>'
                                                    OnClientClick='<%# GetBorrowConfirmScript(Eval("Title")) %>'>
                                                    <i class='<%# GetBorrowButtonIcon(Eval("Id")) %>'></i>
                                                    <span><%# GetBorrowButtonText(Eval("Id")) %></span>
                                                </asp:LinkButton>
                                                
                                                <asp:HyperLink ID="lnkMyBooks" runat="server" NavigateUrl="UserBorrowings.aspx" 
                                                    CssClass="action-btn info-btn">
                                                    <i class="fas fa-list"></i>
                                                    <span>My Books</span>
                                                </asp:HyperLink>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <HeaderStyle CssClass="table-header-professional" />
                                
                                <EmptyDataTemplate>
                                    <div class="empty-state-professional">
                                        <div class="empty-icon">
                                            <i class="fas fa-search"></i>
                                        </div>
                                        <h4 class="empty-title">No Books Found</h4>
                                        <p class="empty-description">
                                            We couldn't find any books matching your search criteria. 
                                            Try adjusting your search terms or browse all available books.
                                        </p>
                                        <div class="empty-actions">
                                            <asp:Button ID="btnShowAllEmpty" runat="server" Text="Browse All Books" 
                                                OnClick="btnShowAll_Click" CssClass="empty-btn primary-empty" 
                                                CausesValidation="false" />
                                        </div>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </section>

                <!-- Quick Actions Section -->
                <section class="quick-actions-section">
                    <div class="quick-actions-container">
                        <h3 class="quick-actions-title">Quick Actions</h3>
                        <div class="quick-actions-grid">
                            <a href="Welcome.aspx" class="quick-action-card">
                                <div class="action-icon">
                                    <i class="fas fa-home"></i>
                                </div>
                                <div class="action-content">
                                    <h5>Return Home</h5>
                                    <p>Go back to main dashboard</p>
                                </div>
                            </a>
                            
                            <asp:HyperLink ID="lnkMyBooks" runat="server" NavigateUrl="UserLogin.aspx" CssClass="quick-action-card">
                                <div class="action-icon">
                                    <i class="fas fa-book-reader"></i>
                                </div>
                                <div class="action-content">
                                    <h5>My Borrowings</h5>
                                    <p>View borrowed books</p>
                                </div>
                            </asp:HyperLink>
                            
                            <a href="#" class="quick-action-card">
                                <div class="action-icon">
                                    <i class="fas fa-question-circle"></i>
                                </div>
                                <div class="action-content">
                                    <h5>Help & Support</h5>
                                    <p>Get assistance</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </section>
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
                            <h6>Catalog</h6>
                            <ul>
                                <li><a href="BookCatalog.aspx">Browse Books</a></li>
                                <li><a href="#">Advanced Search</a></li>
                                <li><a href="#">New Arrivals</a></li>
                            </ul>
                        </div>
                        <div class="link-group">
                            <h6>Support</h6>
                            <ul>
                                <li><a href="#">User Guide</a></li>
                                <li><a href="#">Contact</a></li>
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