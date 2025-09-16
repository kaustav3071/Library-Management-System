<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="LibraryManagementSystem.Books" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Books | Library System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/books-modern.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- Admin Header -->
            <div class="admin-header fade-in">
                <div class="admin-info">
                    <div class="admin-badge">
                        <i class="fas fa-shield-alt"></i>
                        <span>Admin Panel</span>
                    </div>
                    <div class="admin-details">
                        <span class="admin-email">
                            <i class="fas fa-user mr-2"></i>
                            <asp:Label ID="lblAdminEmail" runat="server"></asp:Label>
                        </span>
                        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" 
                            CssClass="btn btn-logout" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <div class="nav-container fade-in">
                <a href="Welcome.aspx" class="nav-link">
                    <i class="fas fa-home mr-2"></i>Home
                </a>
                <a href="Members.aspx" class="nav-link">
                    <i class="fas fa-users mr-2"></i>Members
                </a>
                <a href="Borrowings.aspx" class="nav-link">
                    <i class="fas fa-exchange-alt mr-2"></i>Borrowings
                </a>
            </div>

            <!-- Page Header -->
            <div class="page-header fade-in">
                <h2>
                    <i class="fas fa-book mr-3"></i>Books
                </h2>
                <p class="subtitle mb-0">Add new books and manage your library catalog (Admin Only)</p>
            </div>

            <!-- Add Book Form -->
            <div class="form-container fade-in">
                <h3 class="mb-4">
                    <i class="fas fa-plus-circle mr-2"></i>Add New Book
                </h3>

                <asp:ValidationSummary ID="valSummary" runat="server" ValidationGroup="AddBook" CssClass="alert alert-danger" ShowSummary="true" />

                <div class="form-group">
                    <asp:Label ID="lblTitle" runat="server" AssociatedControlID="txtTitle" CssClass="font-weight-bold" Text="Book Title"></asp:Label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter book title"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqTitle" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="AddBook" />
                </div>

                <div class="form-group">
                    <asp:Label ID="lblAuthor" runat="server" AssociatedControlID="txtAuthor" CssClass="font-weight-bold" Text="Author Name"></asp:Label>
                    <asp:TextBox ID="txtAuthor" runat="server" CssClass="form-control" placeholder="Enter author name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqAuthor" runat="server" ControlToValidate="txtAuthor" ErrorMessage="Author is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="AddBook" />
                </div>

                <div class="form-group">
                    <asp:Label ID="lblISBN" runat="server" AssociatedControlID="txtISBN" CssClass="font-weight-bold" Text="ISBN Number"></asp:Label>
                    <asp:TextBox ID="txtISBN" runat="server" CssClass="form-control" placeholder="Enter ISBN (e.g., 978-3-16-148410-0)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqISBN" runat="server" ControlToValidate="txtISBN" ErrorMessage="ISBN is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="AddBook" />
                    <asp:RegularExpressionValidator ID="regexISBN" runat="server" ControlToValidate="txtISBN" ValidationExpression="^[0-9Xx-]+$" ErrorMessage="ISBN should contain digits, dashes, or X." CssClass="text-danger" Display="Dynamic" ValidationGroup="AddBook" />
                </div>

                <asp:Button ID="btnAdd" runat="server" Text="Add Book" OnClick="btnAdd_Click" CssClass="btn btn-primary" ValidationGroup="AddBook" />
                
                <asp:Label ID="lblMessage" runat="server" CssClass="ml-3"></asp:Label>
            </div>

            <!-- Books List -->
            <div class="table-container fade-in">
                <h3 class="mb-4">
                    <i class="fas fa-list mr-2"></i>Books Catalog
                </h3>
                <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" UseAccessibleHeader="true" EmptyDataText="No books available in the catalog.">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="Author" HeaderText="Author" />
                        <asp:BoundField DataField="ISBN" HeaderText="ISBN" />
                    </Columns>
                    <HeaderStyle CssClass="thead-dark" />
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="fas fa-book-open"></i>
                            <h3>No Books Found</h3>
                            <p>Start building your library by adding your first book above.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>