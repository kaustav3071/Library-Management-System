<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookCatalog.aspx.cs" Inherits="LibraryManagementSystem.BookCatalog" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book Catalog | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/book-catalog.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- User Header (if logged in) -->
            <asp:Panel ID="pnlUserHeader" runat="server" CssClass="user-header fade-in" Visible="false">
                <div class="user-info">
                    <div class="user-badge">
                        <i class="fas fa-user"></i>
                        <span>Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                    </div>
                    <div class="user-actions">
                        <a href="UserBorrowings.aspx" class="btn btn-user-dashboard">
                            <i class="fas fa-book-reader mr-2"></i>My Books
                        </a>
                        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" 
                            CssClass="btn btn-logout" CausesValidation="false" />
                    </div>
                </div>
            </asp:Panel>

            <!-- Guest Header (if not logged in) -->
            <asp:Panel ID="pnlGuestHeader" runat="server" CssClass="guest-header fade-in">
                <div class="guest-info">
                    <div class="guest-message">
                        <i class="fas fa-info-circle mr-2"></i>
                        <span>Sign in to borrow books and manage your library account</span>
                    </div>
                    <div class="guest-actions">
                        <a href="UserLogin.aspx" class="auth-btn login-btn">
                            <i class="fas fa-sign-in-alt mr-2"></i>Sign In
                        </a>
                        <a href="UserRegister.aspx" class="auth-btn register-btn">
                            <i class="fas fa-user-plus mr-2"></i>Register
                        </a>
                    </div>
                </div>
            </asp:Panel>

            <!-- Navigation -->
            <div class="nav-container fade-in">
                <a href="Welcome.aspx" class="nav-link">
                    <i class="fas fa-home mr-2"></i>Home
                </a>
                <span class="nav-link active">
                    <i class="fas fa-book mr-2"></i>Book Catalog
                </span>
                <asp:HyperLink ID="lnkMyBooks" runat="server" NavigateUrl="UserLogin.aspx" CssClass="nav-link">
                    <i class="fas fa-list mr-2"></i>My Books
                </asp:HyperLink>
            </div>

            <!-- Page Header -->
            <div class="page-header fade-in">
                <h2>
                    <i class="fas fa-book mr-3"></i>Book Catalog
                </h2>
                <p class="subtitle mb-0">Explore our extensive collection of books across various genres</p>
            </div>

            <!-- Search and Filter -->
            <div class="search-container fade-in">
                <div class="row">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="txtSearch" class="form-label">
                                <i class="fas fa-search mr-2"></i>Search Books
                            </label>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by title, author, or ISBN..." />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">&nbsp;</label>
                            <div>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" 
                                    CssClass="btn btn-search mr-2" CausesValidation="false" />
                                <asp:Button ID="btnShowAll" runat="server" Text="Show All" OnClick="btnShowAll_Click" 
                                    CssClass="btn btn-secondary" CausesValidation="false" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Books Grid -->
            <div class="books-container fade-in">
                <h3 class="section-title">
                    <i class="fas fa-list mr-2"></i>Available Books
                </h3>
                
                <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle mr-2"></i>
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-modern" EmptyDataText="No books found." OnRowCommand="gvBooks_RowCommand" DataKeyNames="Id">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Author" HeaderText="Author" />
                        <asp:BoundField DataField="ISBN" HeaderText="ISBN" />
                        <asp:TemplateField HeaderText="Availability">
                            <ItemTemplate>
                                <span class='<%# GetAvailabilityClass(Eval("Id")) %>'>
                                    <%# GetAvailabilityText(Eval("Id")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnBorrowBook" runat="server" 
                                    CssClass='<%# GetBorrowButtonClass(Eval("Id")) %>'
                                    CommandName="BorrowBook" CommandArgument='<%# Eval("Id") %>'
                                    Enabled='<%# CanBorrowBook(Eval("Id")) %>'
                                    OnClientClick='<%# GetBorrowConfirmScript(Eval("Title")) %>'>
                                    <i class="fas fa-book-reader mr-1"></i>
                                    <%# GetBorrowButtonText(Eval("Id")) %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="table-header" />
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="fas fa-book-open"></i>
                            <h3>No Books Found</h3>
                            <p>No books match your search criteria. Try adjusting your search terms.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>