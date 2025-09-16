<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserBorrowings.aspx.cs" Inherits="LibraryManagementSystem.UserBorrowings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Borrowings | Library Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/user-borrowings.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- User Header -->
            <div class="user-header fade-in">
                <div class="user-info">
                    <div class="user-badge">
                        <i class="fas fa-user"></i>
                        <span>Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                    </div>
                    <div class="user-actions">
                        <asp:Button ID="btnProfile" runat="server" Text="Profile" OnClick="btnProfile_Click" 
                            CssClass="btn btn-user-profile" CausesValidation="false" />
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
                <a href="BookCatalog.aspx" class="nav-link">
                    <i class="fas fa-book mr-2"></i>Browse Books
                </a>
                <span class="nav-link active">
                    <i class="fas fa-list mr-2"></i>My Borrowings
                </span>
            </div>

            <!-- Page Header -->
            <div class="page-header fade-in">
                <h2>
                    <i class="fas fa-list mr-3"></i>My Book Borrowings
                </h2>
                <p class="subtitle mb-0">Manage your borrowed books and borrowing history</p>
            </div>

            <!-- Quick Stats -->
            <div class="stats-container fade-in">
                <div class="row">
                    <div class="col-md-4">
                        <div class="stat-card active-books">
                            <div class="stat-icon">
                                <i class="fas fa-book-reader"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblActiveBorrowings" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Currently Borrowed</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card total-books">
                            <div class="stat-icon">
                                <i class="fas fa-history"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblTotalBorrowings" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Total Borrowed</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-card overdue-books">
                            <div class="stat-icon">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblOverdueBooks" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Overdue Books</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Active Borrowings -->
            <div class="borrowings-container fade-in">
                <h3 class="section-title">
                    <i class="fas fa-book-open mr-2"></i>Currently Borrowed Books
                </h3>
                
                <asp:Panel ID="pnlActiveBorrowings" runat="server">
                    <asp:GridView ID="gvActiveBorrowings" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-modern" EmptyDataText="You have no active borrowings.">
                        <Columns>
                            <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                            <asp:BoundField DataField="BookAuthor" HeaderText="Author" />
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed On" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# GetStatusClass(Eval("DueDate")) %>'>
                                        <%# GetStatusText(Eval("DueDate")) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="table-header" />
                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fas fa-book-open"></i>
                                <h3>No Active Borrowings</h3>
                                <p>You don't have any books currently borrowed. <a href="BookCatalog.aspx">Browse our catalog</a> to find books to borrow.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </asp:Panel>
            </div>

            <!-- Borrowing History -->
            <div class="borrowings-container fade-in">
                <h3 class="section-title">
                    <i class="fas fa-history mr-2"></i>Borrowing History
                </h3>
                
                <asp:Panel ID="pnlBorrowingHistory" runat="server">
                    <asp:GridView ID="gvBorrowingHistory" runat="server" AutoGenerateColumns="False" 
                        CssClass="table table-modern" EmptyDataText="No borrowing history available.">
                        <Columns>
                            <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                            <asp:BoundField DataField="BookAuthor" HeaderText="Author" />
                            <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:BoundField DataField="ReturnDate" HeaderText="Returned" DataFormatString="{0:MMM dd, yyyy}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='<%# GetHistoryStatusClass(Eval("ReturnDate"), Eval("DueDate")) %>'>
                                        <%# GetHistoryStatusText(Eval("ReturnDate"), Eval("DueDate")) %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="table-header" />
                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <i class="fas fa-history"></i>
                                <h3>No History Available</h3>
                                <p>Your borrowing history will appear here once you start borrowing books.</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </asp:Panel>
            </div>

        </div>
    </form>
</body>
</html>