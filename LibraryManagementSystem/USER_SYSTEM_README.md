# Library Management System - User Authentication & Admin Management

## Overview
A comprehensive library management system with dual authentication (User & Admin), featuring user registration, login, book borrowing, and admin-only member management capabilities.

## ?? Features

### User Features
- **User Registration & Login**: Secure user account creation and authentication
- **Personal Dashboard**: View borrowed books, borrowing history, and account stats
- **Book Browsing**: Browse available books in the library catalog
- **Borrowing Management**: Track current loans, due dates, and return status
- **Profile Management**: Update personal information and account settings

### Admin Features
- **Admin Authentication**: Secure admin panel access with environment-based credentials
- **Book Management**: Add, edit, and manage library book inventory
- **User Management**: View all registered users and their borrowing activities
- **Borrowing Oversight**: Monitor all borrowings, overdue books, and library statistics
- **System Administration**: Deactivate/activate user accounts

## ?? Authentication System

### User Authentication
- **Registration**: Users create accounts with name, email, phone, and secure password
- **Login**: Email and password authentication with session management
- **Password Security**: SHA256 hashing for secure password storage
- **Session Management**: Automatic logout on inactivity

### Admin Authentication
- **Environment-based Credentials**: Admin credentials stored in `.env` file
- **Dual Access Control**: Separate admin and user authentication systems
- **Session Security**: Protected admin routes with automatic redirects

## ?? Database Schema

### Users Table
```sql
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(20),
    PasswordHash NVARCHAR(255) NOT NULL,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1
);
```

### Enhanced Borrowings Table
- Added `UserId` column for user-based borrowings
- Maintains backward compatibility with legacy `MemberId` system
- Supports both user accounts and legacy member records

## ?? Modern UI Design

### Responsive Design
- **Mobile-first approach** with Bootstrap 4.6.2
- **Modern CSS** with gradients, shadows, and animations
- **Consistent theming** across all pages
- **Accessibility features** with proper focus states

### Design System
- **Color Palette**: Professional gradients with blue, purple, and complementary colors
- **Typography**: Segoe UI font family for modern appearance
- **Icons**: Font Awesome 6.4.0 for consistent iconography
- **Animations**: Smooth transitions and hover effects

## ?? File Structure

```
LibraryManagementSystem/
??? Content/
?   ??? admin-login.css          # Admin login page styles
?   ??? user-auth.css           # User authentication styles
?   ??? user-borrowings.css     # User dashboard styles
?   ??? books-modern.css        # Books management styles
?   ??? members-modern.css      # Member management styles
?   ??? welcome-modern.css      # Homepage styles
??? DAL/
?   ??? UserDAL.cs             # User data access layer
?   ??? BorrowingDAL.cs        # Enhanced borrowing operations
?   ??? BookDAL.cs             # Book management operations
?   ??? MemberDAL.cs           # Legacy member operations
??? Utils/
?   ??? UserAuth.cs            # User authentication utilities
?   ??? AdminAuth.cs           # Admin authentication utilities
?   ??? EnvReader.cs           # Environment variable reader
??? Database/
?   ??? CreateUserTables.sql   # Database schema script
??? AdminLogin.aspx            # Admin login page
??? UserLogin.aspx             # User login page
??? UserRegister.aspx          # User registration page
??? UserBorrowings.aspx        # User dashboard page
??? Books.aspx                 # Admin book management
??? Members.aspx               # Admin user management
??? Welcome.aspx               # Homepage
??? .env                       # Admin credentials
??? ADMIN_README.md           # Admin system documentation
```

## ??? Setup Instructions

### 1. Database Setup
```sql
-- Run the SQL script to create user tables
-- File: Database/CreateUserTables.sql
```

### 2. Admin Configuration
```env
# Update .env file with admin credentials
ADMIN_EMAIL=admin@library.com
ADMIN_PASSWORD=LibraryAdmin123!
```

### 3. Web.config Updates
- Session timeout configured for 60 minutes
- .env file protection added
- Connection string properly configured

## ?? Usage Guide

### For Users
1. **Registration**: Visit homepage ? "Register" ? Fill form ? Create account
2. **Login**: Homepage ? "Sign In" ? Enter credentials
3. **Browse Books**: Access book catalog from user dashboard
4. **View Borrowings**: Dashboard shows current loans and history
5. **Logout**: Click logout button to end session

### For Administrators
1. **Admin Access**: Homepage ? "Admin Panel" ? Enter admin credentials
2. **Manage Books**: Admin Panel ? "Books" ? Add/edit books
3. **Manage Users**: Admin Panel ? "Members" ? View users and borrowings
4. **Monitor System**: View statistics and overdue books

## ?? Security Features

### Data Protection
- **Password Hashing**: SHA256 encryption for user passwords
- **SQL Injection Prevention**: Parameterized queries throughout
- **Session Security**: Proper session management and timeouts
- **Environment Variables**: Sensitive credentials stored outside code

### Access Control
- **Role-based Access**: Separate user and admin authentication
- **Route Protection**: Automatic redirects for unauthorized access
- **File Security**: .env file blocked from web access
- **Input Validation**: Server-side validation on all forms

## ?? Responsive Features

### Mobile Optimization
- **Responsive tables** with horizontal scrolling
- **Touch-friendly buttons** with appropriate sizing
- **Flexible layouts** that adapt to screen sizes
- **Optimized navigation** for mobile devices

### Cross-browser Compatibility
- **Modern browser support** with graceful degradation
- **CSS fallbacks** for older browsers
- **Progressive enhancement** approach

## ?? Status Indicators

### Borrowing Status
- **Active**: Book currently borrowed
- **Due Soon**: Book due within 3 days
- **Overdue**: Book past due date
- **Returned**: Book successfully returned
- **Returned Late**: Book returned after due date

### User Status
- **Active**: User account is active
- **Inactive**: User account is deactivated

## ?? System Integration

### Backward Compatibility
- **Legacy Members**: System supports existing member records
- **Gradual Migration**: Users can be migrated from members to user accounts
- **Data Integrity**: Borrowing history maintained across transitions

### API-Ready Structure
- **Separated DAL**: Data access layer ready for API conversion
- **Clean Architecture**: Business logic separated from presentation
- **Scalable Design**: Structure supports future enhancements

## ?? Future Enhancements

### Planned Features
- **Book Reservations**: Allow users to reserve books
- **Email Notifications**: Automated reminders for due dates
- **Book Reviews**: User rating and review system
- **Advanced Search**: Filter books by genre, author, availability
- **Reports**: Generate borrowing reports for admins

### Technical Improvements
- **API Development**: RESTful API for mobile app integration
- **Real-time Updates**: SignalR for live notifications
- **Advanced Security**: Two-factor authentication
- **Performance**: Caching and optimization strategies

## ?? Troubleshooting

### Common Issues
1. **Login Problems**: Check credentials and session timeout
2. **Database Errors**: Verify connection string and table existence
3. **Permission Issues**: Ensure proper file permissions for .env
4. **CSS Loading**: Clear browser cache if styles don't load

### Support
- Check application logs for detailed error information
- Verify database connectivity and table structure
- Ensure all required files are properly deployed
- Validate environment variable configuration

## ?? License
This project is developed for educational and library management purposes.

---

**Built with**: ASP.NET Web Forms 4.7.2, SQL Server, Bootstrap 4.6.2, Font Awesome 6.4.0