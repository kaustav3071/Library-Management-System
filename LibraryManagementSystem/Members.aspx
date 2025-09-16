<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="LibraryManagementSystem.Members" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Members | Library System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="Content/members-modern.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container my-4">
            <!-- Admin Header -->
            <div class="admin-header fade-in">
                <div class="admin-info">
                    <div class="admin-badge">
                        <i class="fas fa-shield-alt"></i>
                        <span>Admin Panel - Members</span>
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
                <a href="Books.aspx" class="nav-link">
                    <i class="fas fa-book mr-2"></i>Books
                </a>
                <a href="Borrowings.aspx" class="nav-link">
                    <i class="fas fa-exchange-alt mr-2"></i>Borrowings
                </a>
                <span class="nav-link active">
                    <i class="fas fa-users mr-2"></i>Members
                </span>
            </div>

            <!-- Page Header -->
            <div class="page-header fade-in">
                <h2>
                    <i class="fas fa-users mr-3"></i>Members
                </h2>
                <p class="subtitle mb-0">View and manage registered users and their borrowing activities (Admin Only)</p>
            </div>

            <!-- Member Statistics -->
            <div class="stats-container fade-in">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-card total-users">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Total Users</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card active-users">
                            <div class="stat-icon">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Active Users</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card active-borrowings">
                            <div class="stat-icon">
                                <i class="fas fa-book-reader"></i>
                            </div>
                            <div class="stat-info">
                                <div class="stat-number">
                                    <asp:Label ID="lblActiveBorrowings" runat="server" Text="0"></asp:Label>
                                </div>
                                <div class="stat-label">Active Borrowings</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
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

            <!-- Search Users -->
            <div class="search-container fade-in">
                <div class="row">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="txtSearch" class="form-label">
                                <i class="fas fa-search mr-2"></i>Search Users
                            </label>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name or email..." />
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

            <!-- Users List -->
            <div class="table-container fade-in">
                <h3 class="mb-4">
                    <i class="fas fa-list mr-2"></i>Registered Users
                </h3>
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-striped" DataKeyNames="Id" OnRowCommand="gvUsers_RowCommand" 
                    EmptyDataText="No users found.">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Full Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email Address" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone Number" />
                        <asp:BoundField DataField="CreatedDate" HeaderText="Registered" DataFormatString="{0:MMM dd, yyyy}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# GetUserStatusClass(Eval("IsActive")) %>'>
                                    <%# GetUserStatusText(Eval("IsActive")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnViewBorrowings" runat="server" CssClass="btn btn-sm btn-info mr-1" 
                                    CommandName="ViewBorrowings" CommandArgument='<%# Eval("Id") %>' 
                                    ToolTip="View User's Borrowings">
                                    <i class="fas fa-eye mr-1"></i>Borrowings
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnToggleStatus" runat="server" 
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "btn btn-sm btn-warning" : "btn btn-sm btn-success" %>' 
                                    CommandName="ToggleStatus" CommandArgument='<%# Eval("Id") %>' 
                                    OnClientClick='<%# Convert.ToBoolean(Eval("IsActive")) ? "return confirm(\"Are you sure you want to deactivate this user?\");" : "return confirm(\"Are you sure you want to activate this user?\");" %>'>
                                    <i class='<%# Convert.ToBoolean(Eval("IsActive")) ? "fas fa-user-slash" : "fas fa-user-check" %>'></i>
                                    <%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="thead-dark" />
                    <EmptyDataTemplate>
                        <div class="empty-state">
                            <i class="fas fa-users"></i>
                            <h3>No Users Found</h3>
                            <p>No registered users match your search criteria.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>

            <!-- User Borrowings Modal -->
            <asp:Panel ID="pnlUserBorrowings" runat="server" CssClass="modal-overlay" Style="display: none;">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>
                            <i class="fas fa-book-reader mr-2"></i>
                            User Borrowings - <asp:Label ID="lblSelectedUserName" runat="server"></asp:Label>
                        </h4>
                        <asp:Button ID="btnCloseModal" runat="server" Text="×" CssClass="btn-close" OnClick="btnCloseModal_Click" CausesValidation="false" />
                    </div>
                    <div class="modal-body">
                        <asp:GridView ID="gvUserBorrowings" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-striped" EmptyDataText="This user has no borrowing history.">
                            <Columns>
                                <asp:BoundField DataField="BookTitle" HeaderText="Book Title" />
                                <asp:BoundField DataField="BookAuthor" HeaderText="Author" />
                                <asp:BoundField DataField="BorrowDate" HeaderText="Borrowed" DataFormatString="{0:MMM dd, yyyy}" />
                                <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:MMM dd, yyyy}" />
                                <asp:BoundField DataField="ReturnDate" HeaderText="Returned" DataFormatString="{0:MMM dd, yyyy}" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <span class='<%# GetBorrowingStatusClass(Eval("ReturnDate"), Eval("DueDate")) %>'>
                                            <%# GetBorrowingStatusText(Eval("ReturnDate"), Eval("DueDate")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="thead-light" />
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </form>
</body>
</html>
