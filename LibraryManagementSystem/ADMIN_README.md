# Admin Authentication System - Library Management System

## Overview
This system implements admin-only access for book management functionality with credentials stored securely in a `.env` file.

## Features
- **Secure Admin Authentication**: Admin credentials stored in `.env` file
- **Session Management**: Admin sessions with timeout support
- **Protected Routes**: Books management requires admin authentication
- **Modern UI**: Styled admin login page and admin header
- **Logout Functionality**: Secure admin logout with session cleanup

## Admin Credentials
Admin credentials are stored in the `.env` file:
```
ADMIN_EMAIL=admin@library.com
ADMIN_PASSWORD=LibraryAdmin123!
```

## How It Works

### 1. Environment Configuration
- `.env` file contains admin email and password
- `EnvReader` utility class reads environment variables
- `.env` file is protected from web access via `web.config`

### 2. Authentication Flow
1. User clicks "Admin Panel" on Welcome page
2. Redirected to `AdminLogin.aspx` 
3. Admin enters credentials
4. `AdminAuth.ValidateAdmin()` checks against `.env` values
5. On success, admin session is created
6. Admin is redirected to Books management page

### 3. Protected Pages
- `Books.aspx` requires admin authentication
- `AdminAuth.RequireAdmin()` called on page load
- Non-authenticated users redirected to login

### 4. Session Management
- Admin login state stored in session
- Session timeout configured for 60 minutes
- Logout clears session and redirects to Welcome page

## Files Added/Modified

### New Files:
- `LibraryManagementSystem\.env` - Admin credentials
- `LibraryManagementSystem\Utils\EnvReader.cs` - Environment variable reader
- `LibraryManagementSystem\Utils\AdminAuth.cs` - Authentication utilities
- `LibraryManagementSystem\AdminLogin.aspx` - Admin login page
- `LibraryManagementSystem\AdminLogin.aspx.cs` - Login page code-behind
- `LibraryManagementSystem\AdminLogin.aspx.designer.cs` - Designer file
- `LibraryManagementSystem\Content\admin-login.css` - Login page styles

### Modified Files:
- `LibraryManagementSystem\Books.aspx` - Added admin header and authentication
- `LibraryManagementSystem\Books.aspx.cs` - Added admin authentication checks
- `LibraryManagementSystem\Books.aspx.designer.cs` - Added admin controls
- `LibraryManagementSystem\Content\books-modern.css` - Added admin header styles
- `LibraryManagementSystem\Welcome.aspx` - Added admin panel access link
- `LibraryManagementSystem\Content\welcome-modern.css` - Added admin access styles
- `LibraryManagementSystem\Web.config` - Added session timeout and .env protection

## Security Features

1. **Environment Variables**: Credentials stored outside of code
2. **Session-based Authentication**: No credentials in URLs or cookies
3. **File Protection**: `.env` file blocked from web access
4. **Session Timeout**: Automatic logout after inactivity
5. **Redirect Protection**: Unauthorized access redirects to login

## Usage Instructions

### For Administrators:
1. Navigate to the Library Management System
2. Click "Admin Panel" in the top-right corner
3. Enter admin credentials:
   - Email: `admin@library.com`
   - Password: `LibraryAdmin123!`
4. Access Books management functionality
5. Click "Logout" when finished

### For Developers:
1. Update `.env` file to change admin credentials
2. Credentials are automatically loaded on application start
3. No restart required for credential changes
4. Use `AdminAuth.RequireAdmin()` to protect additional pages

## Customization

### Changing Admin Credentials:
Edit the `.env` file:
```
ADMIN_EMAIL=your-admin@domain.com
ADMIN_PASSWORD=YourSecurePassword!
```

### Adding More Admin Users:
Extend the `AdminAuth.ValidateAdmin()` method to support multiple admins or database-stored credentials.

### Protecting Additional Pages:
Add `AdminAuth.RequireAdmin();` to the `Page_Load` method of any page requiring admin access.

## Error Handling
- Invalid credentials show error message
- Missing `.env` file prevents admin login
- Session expiry redirects to login page
- Build errors are handled gracefully

## Browser Compatibility
- Modern browsers with CSS Grid support
- Responsive design for mobile devices
- Progressive enhancement for older browsers