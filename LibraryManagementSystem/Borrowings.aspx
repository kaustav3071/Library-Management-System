<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Borrowings.aspx.cs" Inherits="LibraryManagementSystem.Borrowings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Transaction Management | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Professional transaction management for administrators" />
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
                            <p class="brand-subtitle">Transaction Management</p>
                        </div>
                    </div>
                    
                    <nav class="admin-navigation">
                        <div class="admin-user-info">
                            <div class="admin-avatar">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <div class="admin-details">
                                <span class="admin-greeting">Administrator</span>
                                <span class="admin-email">System Admin</span>
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
                    <a href="Members.aspx" class="admin-tab">
                        <i class="fas fa-users"></i>
                        <span>Member Management</span>
                    </a>
                    <a href="Borrowings.aspx" class="admin-tab active">
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
                                <i class="fas fa-exchange-alt"></i>
                                Transaction Management
                            </h2>
                            <p class="page-description">
                                Monitor and manage book borrowings, track returns, and handle 
                                overdue items with comprehensive transaction oversight.
                            </p>
                        </div>
                        <div class="header-stats">
                            <div class="quick-stat">
                                <div class="stat-icon transactions-stat">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-label">Active Loans</div>
                                    <div class="stat-value">
                                        <asp:Label ID="lblActiveBorrowings" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Transaction Statistics -->
                <section class="admin-stats-section">
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-icon transactions-stat">
                                <i class="fas fa-book-reader"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">
                                    <asp:Label ID="lblTotalBorrowings" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Total Borrowings</div>
                            </div>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon success-stat">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-number">
                                    <asp:Label ID="lblReturnedBooks" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Returned Books</div>
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

                <!-- Filter Section -->
                <section class="admin-search-section">
                    <div class="search-container">
                        <div class="search-header">
                            <h3 class="search-title">
                                <i class="fas fa-filter"></i>
                                Filter Transactions
                            </h3>
                            <p class="search-subtitle">View transactions by status and timeframe</p>
                        </div>
                        
                        <div class="filter-form">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label class="filter-label">
                                        <i class="fas fa-list"></i>
                                        Transaction Status
                                    </label>
                                    <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="filter-select" 
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                                        <asp:ListItem Value="all" Text="All Transactions" />
                                        <asp:ListItem Value="active" Text="Active Borrowings" Selected="True" />
                                        <asp:ListItem Value="returned" Text="Returned Books" />
                                        <asp:ListItem Value="overdue" Text="Overdue Items" />
                                    </asp:DropDownList>
                                </div>
                                
                                <div class="filter-actions">
                                    <asp:Button ID="btnRefreshData" runat="server" Text="Refresh Data" 
                                        OnClick="btnRefreshData_Click" CssClass="filter-btn primary-filter" 
                                        CausesValidation="false" />
                                    <button type="button" class="filter-btn secondary-filter" onclick="exportTransactions()">
                                        <i class="fas fa-download"></i>
                                        Export
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Transactions Data Section -->
                <section class="admin-data-section">
                    <div class="data-container">
                        <div class="data-header">
                            <h3 class="data-title">
                                <i class="fas fa-list-ul"></i>
                                <asp:Label ID="lblSectionTitle" runat="server" Text="Active Borrowings"></asp:Label>
                            </h3>
                            <div class="data-controls">
                                <button type="button" class="control-btn" onclick="refreshData()">
                                    <i class="fas fa-sync-alt"></i>
                                    Refresh
                                </button>
                                <button type="button" class="control-btn" onclick="bulkReturn()" id="btnBulkReturn" style="display: none;">
                                    <i class="fas fa-check-double"></i>
                                    Bulk Return
                                </button>
                            </div>
                        </div>

                        <div class="professional-table-container">
                            <asp:GridView ID="gvActive" runat="server" AutoGenerateColumns="False" 
                                CssClass="professional-data-table" DataKeyNames="Id" OnRowCommand="gvActive_RowCommand" 
                                EmptyDataText="No transactions found.">
                                <Columns>
                                    <asp:TemplateField HeaderText="Transaction Details" ItemStyle-Width="30%">
                                        <ItemTemplate>
                                            <div class="transaction-info-cell">
                                                <div class="transaction-id">
                                                    <span class="id-badge">#<%# Eval("Id") %></span>
                                                </div>
                                                <div class="transaction-dates">
                                                    <div class="borrow-date">
                                                        <i class="fas fa-calendar-plus"></i>
                                                        Borrowed: <%# Eval("BorrowDate", "{0:MMM dd, yyyy}") %>
                                                    </div>
                                                    <div class="due-date">
                                                        <i class="fas fa-calendar-check"></i>
                                                        Due: <%# Eval("DueDate", "{0:MMM dd, yyyy}") %>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Member Information" ItemStyle-Width="25%">
                                        <ItemTemplate>
                                            <div class="member-info-cell">
                                                <div class="member-avatar">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div class="member-details">
                                                    <h5 class="member-name"><%# GetMemberDisplayName(Eval("UserName"), Eval("UserId"), Eval("MemberId")) %></h5>
                                                    <p class="member-id">Member ID: <%# Eval("UserId") %></p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Book Information" ItemStyle-Width="25%">
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
                                    
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <div class="status-cell">
                                                <span class='<%# GetBorrowingStatusClass(DBNull.Value, Eval("DueDate")) %>'>
                                                    <i class='<%# GetBorrowingStatusIcon(DBNull.Value, Eval("DueDate")) %>'></i>
                                                    <%# GetBorrowingStatusText(DBNull.Value, Eval("DueDate")) %>
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="10%">
                                        <ItemTemplate>
                                            <div class="action-cell">
                                                <asp:LinkButton ID="btnReturn" runat="server" 
                                                    CssClass="table-action-btn success-btn" 
                                                    CommandName="Return" CommandArgument='<%# Eval("Id") %>' 
                                                    OnClientClick="return confirm('Mark this book as returned?');"
                                                    ToolTip="Mark as Returned">
                                                    <i class="fas fa-check"></i>
                                                </asp:LinkButton>
                                                
                                                <button type="button" class="table-action-btn info-btn" 
                                                    onclick="viewDetails('<%# Eval("Id") %>')"
                                                    title="View Details">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <HeaderStyle CssClass="professional-table-header" />
                                
                                <EmptyDataTemplate>
                                    <div class="empty-state-professional">
                                        <div class="empty-icon">
                                            <i class="fas fa-exchange-alt"></i>
                                        </div>
                                        <h4 class="empty-title">No Transactions Found</h4>
                                        <p class="empty-description">
                                            No transactions match the current filter criteria. 
                                            Try changing the filter options or check back later.
                                        </p>
                                        <div class="empty-actions">
                                            <button type="button" class="empty-btn" onclick="showAllTransactions()">
                                                <i class="fas fa-list"></i>
                                                Show All Transactions
                                            </button>
                                        </div>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </section>
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
            document.getElementById('<%= btnRefreshData.ClientID %>').click();
        }

        function exportTransactions() {
            alert('Transaction export functionality will be implemented');
        }

        function viewDetails(transactionId) {
            alert('View transaction details for ID: ' + transactionId);
        }

        function bulkReturn() {
            alert('Bulk return functionality will be implemented');
        }

        function showAllTransactions() {
            document.getElementById('<%= ddlStatusFilter.ClientID %>').value = 'all';
            document.getElementById('<%= btnRefreshData.ClientID %>').click();
        }

        // Initialize interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Show/hide bulk return button based on filter
            const statusFilter = document.getElementById('<%= ddlStatusFilter.ClientID %>');
            const bulkReturnBtn = document.getElementById('btnBulkReturn');
            
            function toggleBulkReturn() {
                if (statusFilter.value === 'active') {
                    bulkReturnBtn.style.display = 'inline-flex';
                } else {
                    bulkReturnBtn.style.display = 'none';
                }
            }
            
            statusFilter.addEventListener('change', toggleBulkReturn);
            toggleBulkReturn(); // Initial check
        });
    </script>
</body>
</html>
