<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Borrowings.aspx.cs" Inherits="LibraryManagementSystem.Borrowings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Borrowings | Library System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/borrowings-modern.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- Admin Header -->
            <div class="admin-header fade-in">
                <div class="admin-info">
                    <div class="admin-badge">
                        <i class="fas fa-shield-alt"></i>
                        <span>Admin Panel - Borrowings</span>
                    </div>
                    <div class="admin-details">
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
                <a href="Books.aspx" class="nav-link">
                    <i class="fas fa-book mr-2"></i>Books
                </a>
                <a href="Members.aspx" class="nav-link">
                    <i class="fas fa-users mr-2"></i>Members
                </a>
                <span class="nav-link active">
                    <i class="fas fa-exchange-alt mr-2"></i>Borrowings
                </span>
            </div>

            <!-- Page Header -->
            <div class="page-header fade-in">
                <h2>
                    <i class="fas fa-exchange-alt mr-3"></i>Borrowings
                </h2>
                <p class="subtitle mb-0">Track book loans, manage returns, and monitor overdue items (Admin Only)</p>
            </div>

            <!-- Active Borrowings -->
            <div class="table-container fade-in">
                <h3 class="mb-4">
                    <i class="fas fa-clock mr-2"></i>Active Borrowings
                </h3>
                <asp:GridView ID="gvActive" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" DataKeyNames="Id" OnRowCommand="gvActive_RowCommand" EmptyDataText="No active borrowings.">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:TemplateField HeaderText="Member">
                            <ItemTemplate>
                                <%# GetMemberDisplayName(Eval("UserName"), Eval("UserId"), Eval("MemberId")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Book">
                            <ItemTemplate>
                                <strong><%# Eval("BookTitle") %></strong><br />
                                <small class="text-muted">by <%# Eval("BookAuthor") %></small>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# GetBorrowingStatusClass(DBNull.Value, Eval("DueDate")) %>'>
                                    <%# GetBorrowingStatusText(DBNull.Value, Eval("DueDate")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnReturn" runat="server" CssClass="btn btn-sm btn-success" CommandName="Return" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Mark this book as returned?');">
                                    <i class="fas fa-check mr-1"></i>Return
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="thead-dark" />
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="fas fa-book-open"></i>
                            <h3>No Active Borrowings</h3>
                            <p>No books are currently borrowed from the library.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>
