<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="LibraryManagementSystem.Books" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Collection Management | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Professional book collection management for administrators" />
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
                            <p class="brand-subtitle">Collection Management</p>
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
                    <a href="Books.aspx" class="admin-tab active">
                        <i class="fas fa-book"></i>
                        <span>Collection Management</span>
                    </a>
                    <a href="Members.aspx" class="admin-tab">
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
                                <i class="fas fa-book"></i>
                                Collection Management
                            </h2>
                            <p class="page-description">
                                Add, edit, and organize your library's book collection with comprehensive 
                                catalog management tools.
                            </p>
                        </div>
                        <div class="header-stats">
                            <div class="quick-stat">
                                <div class="stat-icon books-stat">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <div class="stat-info">
                                    <div class="stat-label">Total Books</div>
                                    <div class="stat-value">
                                        <asp:Label ID="lblTotalBooks" runat="server" Text="0"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Add Book Section -->
                <section class="admin-form-section">
                    <div class="form-container">
                        <div class="form-header">
                            <h3 class="form-title">
                                <i class="fas fa-plus-circle"></i>
                                Add New Book
                            </h3>
                            <p class="form-subtitle">Expand your library collection with new titles</p>
                        </div>

                        <asp:Label ID="lblMessage" runat="server" CssClass="message-display"></asp:Label>
                        
                        <asp:ValidationSummary ID="valSummary" runat="server" ValidationGroup="AddBook" 
                            CssClass="validation-summary" ShowSummary="true" />

                        <div class="professional-form">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-book"></i>
                                        Book Title
                                    </label>
                                    <div class="input-wrapper">
                                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-input" 
                                            placeholder="Enter the complete book title"></asp:TextBox>
                                        <div class="input-focus-border"></div>
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqTitle" runat="server" ControlToValidate="txtTitle" 
                                        ErrorMessage="Book title is required." CssClass="field-validation-error" 
                                        Display="Dynamic" ValidationGroup="AddBook" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-user-edit"></i>
                                        Author Name
                                    </label>
                                    <div class="input-wrapper">
                                        <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-input" 
                                            placeholder="Enter author's full name"></asp:TextBox>
                                        <div class="input-focus-border"></div>
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqAuthor" runat="server" ControlToValidate="txtAuthor" 
                                        ErrorMessage="Author name is required." CssClass="field-validation-error" 
                                        Display="Dynamic" ValidationGroup="AddBook" />
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-barcode"></i>
                                        ISBN Number
                                    </label>
                                    <div class="input-wrapper">
                                        <asp:TextBox ID="txtISBN" runat="server" CssClass="form-input" 
                                            placeholder="Enter ISBN (e.g., 978-3-16-148410-0)"></asp:TextBox>
                                        <div class="input-focus-border"></div>
                                    </div>
                                    <asp:RequiredFieldValidator ID="reqISBN" runat="server" ControlToValidate="txtISBN" 
                                        ErrorMessage="ISBN is required." CssClass="field-validation-error" 
                                        Display="Dynamic" ValidationGroup="AddBook" />
                                    <asp:RegularExpressionValidator ID="regexISBN" runat="server" ControlToValidate="txtISBN" 
                                        ValidationExpression="^[0-9Xx-]+$" ErrorMessage="ISBN should contain digits, dashes, or X." 
                                        CssClass="field-validation-error" Display="Dynamic" ValidationGroup="AddBook" />
                                </div>
                            </div>

                            <div class="form-actions">
                                <asp:Button ID="btnAdd" runat="server" Text="Add to Collection" OnClick="btnAdd_Click" 
                                    CssClass="action-btn primary-action" ValidationGroup="AddBook" />
                                <button type="button" class="action-btn secondary-action" onclick="clearForm()">
                                    <i class="fas fa-eraser"></i>
                                    Clear Form
                                </button>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Books Collection Section -->
                <section class="admin-data-section">
                    <div class="data-container">
                        <div class="data-header">
                            <h3 class="data-title">
                                <i class="fas fa-library"></i>
                                Current Collection
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
                            <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" 
                                CssClass="professional-data-table" UseAccessibleHeader="true" 
                                EmptyDataText="No books available in the catalog.">
                                <Columns>
                                    <asp:TemplateField HeaderText="Book Information" ItemStyle-Width="40%">
                                        <ItemTemplate>
                                            <div class="book-info-cell">
                                                <div class="book-icon">
                                                    <i class="fas fa-book"></i>
                                                </div>
                                                <div class="book-details">
                                                    <h5 class="book-title"><%# Eval("Title") %></h5>
                                                    <p class="book-author">by <%# Eval("Author") %></p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="ISBN" ItemStyle-Width="25%">
                                        <ItemTemplate>
                                            <div class="isbn-cell">
                                                <span class="isbn-code"><%# Eval("ISBN") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <div class="status-cell">
                                                <span class="status-badge available">
                                                    <i class="fas fa-check-circle"></i>
                                                    Available
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="15%">
                                        <ItemTemplate>
                                            <div class="action-cell">
                                                <button type="button" class="table-action-btn edit-btn" 
                                                    onclick="editBook('<%# Eval("Id") %>')">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button type="button" class="table-action-btn delete-btn" 
                                                    onclick="deleteBook('<%# Eval("Id") %>', '<%# Eval("Title") %>')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <HeaderStyle CssClass="professional-table-header" />
                                
                                <EmptyDataTemplate>
                                    <div class="empty-state-professional">
                                        <div class="empty-icon">
                                            <i class="fas fa-book-open"></i>
                                        </div>
                                        <h4 class="empty-title">No Books in Collection</h4>
                                        <p class="empty-description">
                                            Start building your library collection by adding your first book using the form above.
                                        </p>
                                        <div class="empty-actions">
                                            <button type="button" class="empty-btn" onclick="focusAddForm()">
                                                <i class="fas fa-plus"></i>
                                                Add First Book
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
        function clearForm() {
            document.getElementById('<%= txtTitle.ClientID %>').value = '';
            document.getElementById('<%= txtAuthor.ClientID %>').value = '';
            document.getElementById('<%= txtISBN.ClientID %>').value = '';
            document.getElementById('<%= txtTitle.ClientID %>').focus();
        }

        function refreshData() {
            window.location.reload();
        }

        function exportData() {
            // Implement export functionality
            alert('Export functionality will be implemented');
        }

        function editBook(bookId) {
            // Implement edit functionality
            alert('Edit functionality will be implemented for book ID: ' + bookId);
        }

        function deleteBook(bookId, title) {
            if (confirm('Are you sure you want to delete "' + title + '"?')) {
                // Implement delete functionality
                alert('Delete functionality will be implemented for book ID: ' + bookId);
            }
        }

        function focusAddForm() {
            document.getElementById('<%= txtTitle.ClientID %>').focus();
            document.getElementById('<%= txtTitle.ClientID %>').scrollIntoView({ behavior: 'smooth' });
        }

        // Initialize form interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Input focus effects
            const inputs = document.querySelectorAll('.form-input');
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