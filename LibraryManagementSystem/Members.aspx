<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="LibraryManagementSystem.Members" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Member Management | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Professional member management for administrators" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/admin-professional.css" />
</head>
<body>
    <form id="form1" runat="server">
        <!-- Professional Admin Header -->
        <header class="admin-header">
            <div class="container">
                <div class="header-content">
                    <div class="brand-section">
                        <div class="brand-logo admin-logo">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="brand-info">
                            <h1 class="brand-title">Admin Console</h1>
                            <p class="brand-subtitle">Member Management</p>
                        </div>
                    </div>
                    
                    <nav class="admin-navigation">
                        <div class="admin-user-info">
                            <div class="admin-avatar">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <div class="admin-details">
                                <span class="admin-greeting">Administrator</span>
                                <span class="admin-email"><asp:Label ID="lblAdminEmail" runat="server"></asp:Label></span>
                            </div>
                        </div>
                        <div class="admin-actions">
                            <a href="Welcome.aspx" class="nav-btn dashboard-btn">
                                <i class="fas fa-home"></i>
                                <span>Dashboard</span>
                            </a>
                            <asp:Button ID="btnLogout" runat="server" Text="Sign Out" OnClick="btnLogout_Click" 
                                CssClass="nav-btn logout-btn" CausesValidation="false" />
                        </div>
                    </nav>
                </div>
            </div>
        </header>

        <!-- Admin Navigation Tabs -->
        <section class="admin-tabs-section">
            <div class="container">
                <nav class="admin-tabs">
                    <a href="Books.aspx" class="admin-tab">
                        <i class="fas fa-book"></i>
                        <span>Collection Management</span>
                    </a>
                    <a href="Members.aspx" class="admin-tab active">
                        <i class="fas fa-users"></i>
                        <span>Member Management</span>
                    </a>
                    <a href="Borrowings.aspx" class="admin-tab">
                        <i class="fas fa-exchange-alt"></i>
                        <span>Transaction Management</span>
                    </a>
                </nav>
            </div>
        </section>

        <!-- Main Content -->
        <main class="admin-main-content">
            <div class="container">
                <!-- Page Header -->
                <section class="admin-page-header">
                    <div class="page-header-content">
                        <div class="header-info">
                            <h2 class="page-title">
                                <i class="fas fa-users"></i>
                                Member Management
                            </h2>
                            <p class="page-description">
                                Monitor and manage library members, track their activity, and oversee 
                                borrowing privileges and account status.
                            </p>
                        </div>
                        <div class="header-stats">
                            <div class="quick-stat">
                                <div class="stat-icon members-stat">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-label">Total Members</div>
                                    <div class="stat-value">
                                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Statistics Section -->
                <section class="admin-stats-section">
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon members-stat">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">
                                    <asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Active Members</div>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon transactions-stat">
                                <i class="fas fa-book-reader"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">
                                    <asp:Label ID="lblActiveBorrowings" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Active Borrowings</div>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon danger-stat">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">
                                    <asp:Label ID="lblOverdueBooks" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Overdue Books</div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Search Section -->
                <section class="admin-search-section">
                    <div class="search-container">
                        <div class="search-header">
                            <h3 class="search-title">
                                <i class="fas fa-search"></i>
                                Find Members
                            </h3>
                            <p class="search-subtitle">Search by name, email, or member details</p>
                        </div>
                        
                        <div class="search-form">
                            <div class="search-input-group">
                                <div class="search-input-container">
                                    <i class="fas fa-search search-icon"></i>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input" 
                                        placeholder="Enter member name or email address..." />
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

                <!-- Members Data Section -->
                <section class="admin-data-section">
                    <div class="data-container">
                        <div class="data-header">
                            <h3 class="data-title">
                                <i class="fas fa-list-ul"></i>
                                Registered Members
                            </h3>
                            <div class="data-controls">
                                <button type="button" class="control-btn" onclick="refreshData()">
                                    <i class="fas fa-sync-alt"></i>
                                    Refresh
                                </button>
                                <button type="button" class="control-btn" onclick="exportData()">
                                    <i class="fas fa-download"></i>
                                    Export
                                </button>
                            </div>
                        </div>

                        <div class="professional-table-container">
                            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                                CssClass="professional-data-table" DataKeyNames="Id" OnRowCommand="gvUsers_RowCommand" 
                                EmptyDataText="No users found.">
                                <Columns>
                                    <asp:TemplateField HeaderText="Member Information" ItemStyle-Width="35%">
                                        <ItemTemplate>
                                            <div class="member-info-cell">
                                                <div class="member-avatar">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div class="member-details">
                                                    <h5 class="member-name"><%# Eval("Name") %></h5>
                                                    <p class="member-email"><%# Eval("Email") %></p>
                                                    <span class="member-phone"><%# Eval("Phone") %></span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Registration" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <div class="registration-cell">
                                                <span class="registration-date"><%# Eval("CreatedDate", "{0:MMM dd, yyyy}") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <div class="status-cell">
                                                <span class='<%# GetUserStatusClass(Eval("IsActive")) %>'>
                                                    <i class='<%# GetUserStatusIcon(Eval("IsActive")) %>'></i>
                                                    <%# GetUserStatusText(Eval("IsActive")) %>
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="35%">
                                        <ItemTemplate>
                                            <div class="action-cell">
                                                <asp:LinkButton ID="btnViewBorrowings" runat="server" 
                                                    CssClass="table-action-btn info-btn" 
                                                    CommandName="ViewBorrowings" CommandArgument='<%# Eval("Id") %>' 
                                                    ToolTip="View Member's Borrowings">
                                                    <i class="fas fa-eye"></i>
                                                </asp:LinkButton>
                                                
                                                <asp:LinkButton ID="btnToggleStatus" runat="server" 
                                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "table-action-btn warning-btn" : "table-action-btn success-btn" %>' 
                                                    CommandName="ToggleStatus" CommandArgument='<%# Eval("Id") %>' 
                                                    OnClientClick='<%# Convert.ToBoolean(Eval("IsActive")) ? "return confirm(\"Are you sure you want to deactivate this member?\");" : "return confirm(\"Are you sure you want to activate this member?\");" %>'
                                                    ToolTip='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate Member" : "Activate Member" %>'>
                                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "fas fa-user-slash" : "fas fa-user-check" %>'></i>
                                                </asp:LinkButton>
                                                
                                                <button type="button" class="table-action-btn edit-btn" 
                                                    onclick="editMember('<%# Eval("Id") %>', '<%# Eval("Name") %>')"
                                                    title="Edit Member">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <HeaderStyle CssClass="professional-table-header" />
                                
                                <EmptyDataTemplate>
                                    <div class="empty-state-professional">
                                        <div class="empty-icon">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <h4 class="empty-title">No Members Found</h4>
                                        <p class="empty-description">
                                            No registered members match your search criteria. 
                                            Try adjusting your search terms or check back later.
                                        </p>
                                        <div class="empty-actions">
                                            <button type="button" class="empty-btn" onclick="showAll()">
                                                <i class="fas fa-users"></i>
                                                Show All Members
                                            </button>
                                        </div>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </section>

                <!-- Member Borrowings Modal -->
                <asp:Panel ID="pnlUserBorrowings" runat="server" CssClass="modal-overlay" Style="display: none;">
                    <div class="modal-content-professional">
                        <div class="modal-header-professional">
                            <h4 class="modal-title">
                                <i class="fas fa-book-reader"></i>
                                Member Borrowings - <asp:Label ID="lblSelectedUserName" runat="server"></asp:Label>
                            </h4>
                            <asp:Button ID="btnCloseModal" runat="server" Text="×" CssClass="modal-close-btn" 
                                OnClick="btnCloseModal_Click" CausesValidation="false" />
                        </div>
                        <div class="modal-body-professional">
                            <asp:GridView ID="gvUserBorrowings" runat="server" AutoGenerateColumns="False" 
                                CssClass="professional-data-table" EmptyDataText="This member has no borrowing history.">
                                <Columns>
                                    <asp:TemplateField HeaderText="Book Information" ItemStyle-Width="40%">
                                        <ItemTemplate>
                                            <div class="book-info-cell">
                                                <div class="book-icon">
                                                    <i class="fas fa-book"></i>
                                                </div>
                                                <div class="book-details">
                                                    <h5 class="book-title"><%# Eval("BookTitle") %></h5>
                                                    <p class="book-author">by <%# Eval("BookAuthor") %></p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed" 
                                        DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="15%" />
                                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" 
                                        DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="15%" />
                                    <asp:BoundField DataField="ReturnDate" HeaderText="Returned" 
                                        DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="15%" />
                                    
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <span class='<%# GetBorrowingStatusClass(Eval("ReturnDate"), Eval("DueDate")) %>'>
                                                <i class='<%# GetBorrowingStatusIcon(Eval("ReturnDate"), Eval("DueDate")) %>'></i>
                                                <%# GetBorrowingStatusText(Eval("ReturnDate"), Eval("DueDate")) %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="professional-table-header" />
                            </asp:GridView>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </main>

        <!-- Professional Footer -->
        <footer class="admin-footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-info">
                        <p>&copy; <%= DateTime.Now.Year %> Library Management System - Administrative Console</p>
                        <p>Professional Digital Library Solutions</p>
                    </div>
                    <div class="footer-links">
                        <a href="Welcome.aspx">Dashboard</a>
                        <a href="#">Help</a>
                        <a href="#">Support</a>
                    </div>
                </div>
            </div>
        </footer>
    </form>

    <script>
        function refreshData() {
            window.location.reload();
        }

        function exportData() {
            alert('Export functionality will be implemented');
        }

        function editMember(memberId, memberName) {
            alert('Edit functionality will be implemented for member: ' + memberName + ' (ID: ' + memberId + ')');
        }

        function showAll() {
            document.getElementById('<%= btnShowAll.ClientID %>').click();
        }

        // Initialize interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Modal close functionality
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('modal-overlay')) {
                    document.getElementById('<%= btnCloseModal.ClientID %>').click();
                }
            });
        });
    </script>
</body>
</html>
