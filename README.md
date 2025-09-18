# 📚 Library Management System

A comprehensive web-based Library Management System built with **ASP.NET Web Forms** targeting **.NET Framework 4.7.2**. This application provides a complete solution for managing library operations including book cataloging, user management, borrowing transactions, and administrative oversight.

![Library Management System](https://img.shields.io/badge/ASP.NET-Web%20Forms-blue)
![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.7.2-purple)
![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-red)
![Bootstrap](https://img.shields.io/badge/Frontend-Bootstrap%205-success)

## 🌟 Features Overview

### 👥 **User Portal**
- **User Registration & Authentication** - Secure account creation and login
- **Book Catalog Browsing** - Search and explore the complete book collection
- **Book Borrowing System** - Request and manage book loans
- **Personal Dashboard** - Track borrowing history and current loans
- **Profile Management** - Update personal information and preferences

### 🛡️ **Administrative Portal**
- **Command Center Login** - Professional, security-focused admin interface
- **Book Management** - Complete CRUD operations for book inventory
- **User Management** - Monitor and manage registered library members
- **Borrowing Management** - Track, approve, and process book returns
- **Analytics Dashboard** - Comprehensive statistics and reporting
- **System Configuration** - Manage library policies and settings

### 🎨 **Design & User Experience**
- **Responsive Design** - Optimized for desktop, tablet, and mobile devices
- **Professional UI** - Modern, clean interface with intuitive navigation
- **Dark Admin Theme** - Sophisticated command center aesthetic for administrators
- **Accessibility Compliant** - WCAG guidelines implementation
- **Interactive Elements** - Smooth animations and real-time feedback

## 🛠️ Technology Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| **Backend Framework** | ASP.NET Web Forms | .NET Framework 4.7.2 |
| **Database** | Microsoft SQL Server | LocalDB/SQL Server Express |
| **Frontend Framework** | Bootstrap | 5.3.0 |
| **Styling** | CSS3 | Custom Professional Themes |
| **JavaScript** | ES6+ | Vanilla JavaScript |
| **Icons** | Font Awesome | 6.4.0 |
| **Typography** | Inter, Segoe UI | Google Fonts |
| **Development IDE** | Visual Studio | 2019/2022 |

## 📋 Prerequisites

Before setting up the Library Management System, ensure you have:

- **Operating System**: Windows 10/11 or Windows Server 2016+
- **Development Environment**: Visual Studio 2019/2022 (Community, Professional, or Enterprise)
- **.NET Framework**: 4.7.2 or higher
- **Database**: SQL Server LocalDB (included with Visual Studio) or SQL Server Express/Standard
- **Web Server**: IIS Express (for development) or IIS (for production)
- **Browser**: Modern web browser (Chrome, Firefox, Edge, Safari)

## 🚀 Installation & Setup

### 1. **Clone the Repository**
```bash
git clone https://github.com/kaustav3071/Library-Management-System.git
cd Library-Management-System
```

### 2. **Database Configuration**

#### **Option A: Using SQL Server Management Studio**
1. Open SQL Server Management Studio (SSMS)
2. Connect to your SQL Server instance: `(localdb)\MSSQLLocalDB`
3. Create a new database named `LibraryDB`
4. Execute the database setup script:
   ```sql
   -- Execute the file: Database/CompleteSchemaSetup.sql
   ```

#### **Option B: Using Visual Studio**
1. Open Visual Studio
2. Go to **View** → **SQL Server Object Explorer**
3. Connect to `(localdb)\MSSQLLocalDB`
4. Right-click on **Databases** → **Add New Database** → Name it `LibraryDB`
5. Right-click on the new database → **New Query**
6. Copy and execute the contents of `Database/CompleteSchemaSetup.sql`

### 3. **Connection String Configuration**
Verify the connection string in `Web.config`:
```xml
<connectionStrings>
  <add name="LibraryDBConnection"
       connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=LibraryDB;Integrated Security=True;Connect Timeout=30;MultipleActiveResultSets=True"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

### 4. **Environment Variables Setup**
The `.env` file contains essential configuration:
```env
ADMIN_EMAIL=admin email
ADMIN_PASSWORD= admin password
```

### 5. **Build and Run**
1. Open `LibraryManagementSystem.sln` in Visual Studio
2. **Restore NuGet Packages**: Right-click solution → **Restore NuGet Packages**
3. **Build Solution**: Press `Ctrl+Shift+B` or **Build** → **Build Solution**
4. **Run Application**: Press `F5` or `Ctrl+F5`
5. Navigate to: `https://localhost:44331/`

## 🔐 Access Credentials

### **Administrator Access**
- **Login URL**: `/AdminLogin.aspx`
- **Email**: `admin email`
- **Password**: `admin password`
- **Dashboard**: Command Center interface with full system control

### **Test User Account**
- **Login URL**: `/UserLogin.aspx`
- **Email**: `test@example.com`
- **Password**: `password123`
- **Features**: Full user portal access with borrowing capabilities

## 📁 Project Architecture

```
LibraryManagementSystem/
├── 📄 Global.asax                   # Application lifecycle events
├── 📄 Site.Master                   # Master page template
├── 📄 Web.config                    # Application configuration
├── 📄 .env                          # Environment variables
│
├── 🏠 Landing & Welcome/
│   └── 📄 Welcome.aspx              # Home page with navigation
│
├── 👤 User Interface/
│   ├── 📄 UserLogin.aspx            # User authentication
│   ├── 📄 UserRegister.aspx         # New user registration
│   ├── 📄 BookCatalog.aspx          # Browse and search books
│   └── 📄 UserBorrowings.aspx       # Personal dashboard
│
├── 🛡️ Admin Interface/
│   ├── 📄 AdminLogin.aspx           # Admin command center login
│   ├── 📄 Books.aspx                # Book inventory management
│   ├── 📄 Members.aspx              # User account management
│   └── 📄 Borrowings.aspx           # Transaction oversight
│
├── 🗂️ Data Access Layer (DAL)/
│   ├── 📄 BookDAL.cs                # Book database operations
│   ├── 📄 UserDAL.cs                # User account operations
│   ├── 📄 BorrowingDAL.cs           # Borrowing transaction logic
│   └── 📄 MemberDAL.cs              # Legacy member support
│
├── 🔧 Utilities/
│   ├── 📄 UserAuth.cs               # User session management
│   ├── 📄 AdminAuth.cs              # Admin authentication
│   └── 📄 EnvReader.cs              # Environment configuration
│
├── 🎨 Content & Styling/
│   ├── 📄 admin-professional.css    # Command center styling
│   ├── 📄 auth-layout-fixed.css     # Authentication pages
│   ├── 📄 welcome-professional.css  # Landing page design
│   └── 📄 [various theme files]     # Component-specific styles
│
├── 📚 Database Scripts/
│   ├── 📄 CompleteSchemaSetup.sql   # Full database initialization
│   ├── 📄 CreateUserTables.sql      # User system setup
│   └── 📄 FixBorrowingsTable.sql    # Database maintenance
│
└── 📦 Dependencies/
    ├── 📁 Scripts/                  # JavaScript libraries
    ├── 📁 Content/                  # CSS frameworks
    └── 📁 packages/                 # NuGet packages
```

## 🗃️ Database Schema

### **Core Tables**

#### **Users Table**
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

#### **Books Table**
```sql
CREATE TABLE Books (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(255) NOT NULL,
    ISBN NVARCHAR(50) NOT NULL
);
```

#### **Borrowings Table**
```sql
CREATE TABLE Borrowings (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NULL,
    MemberId INT NULL,                  -- Legacy support
    BookId INT NOT NULL,
    BorrowDate DATETIME NOT NULL DEFAULT GETDATE(),
    DueDate DATETIME NULL,
    ReturnDate DATETIME NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);
```

### **Sample Data Included**
- **3 Test Users** with different permission levels
- **5 Sample Books** across various genres and authors
- **Sample Borrowing Records** demonstrating system workflows

## 🎯 User Guide

### **For Library Members**

1. **Getting Started**
   - Visit `/UserRegister.aspx` to create your account
   - Verify your email and complete profile setup
   - Login at `/UserLogin.aspx` with your credentials

2. **Browsing Books**
   - Access the catalog at `/BookCatalog.aspx`
   - Use search filters to find specific books
   - View book details, availability status, and author information

3. **Borrowing Process**
   - Click **"Borrow Book"** on available titles
   - Confirm borrowing details and due date
   - Track your loans in the personal dashboard

4. **Managing Your Account**
   - View borrowing history at `/UserBorrowings.aspx`
   - Update personal information and contact details
   - Monitor due dates and return status

### **For Library Administrators**

1. **Accessing Admin Portal**
   - Navigate to `/AdminLogin.aspx`
   - Use the command center interface design
   - Access comprehensive administrative tools

2. **Book Management** (`/Books.aspx`)
   - Add new books to the library inventory
   - Edit existing book information (title, author, ISBN)
   - Monitor book availability and borrowing statistics

3. **Member Management** (`/Members.aspx`)
   - View all registered library members
   - Activate or deactivate user accounts
   - Search and filter user records
   - View individual borrowing histories

4. **Transaction Management** (`/Borrowings.aspx`)
   - Monitor all borrowing transactions
   - Process book returns
   - Track overdue items and generate reports
   - Filter transactions by status (active, returned, overdue)

## ⚙️ Configuration Guide

### **Web.config Settings**
```xml
<system.web>
  <!-- Session Configuration -->
  <sessionState mode="InProc" timeout="60" cookieless="false" />
  
  <!-- Authentication -->
  <authentication mode="Forms">
    <forms timeout="60" />
  </authentication>
  
  <!-- Security -->
  <httpCookies httpOnlyCookies="true" requireSSL="false" />
</system.web>
```

### **Environment Variables (.env)**
```env
# Admin Credentials
ADMIN_EMAIL=admin email
ADMIN_PASSWORD=admin password

# Database Configuration (optional)
# DB_CONNECTION_STRING=your_custom_connection_string

# Application Settings (optional)
# APP_NAME=Library Management System
# APP_VERSION=1.0.0
```

### **Security Configuration**
- **Password Hashing**: SHA-256 encryption
- **Session Management**: Secure session handling with 60-minute timeout
- **SQL Injection Protection**: Parameterized queries throughout
- **Input Validation**: Client and server-side validation
- **Admin Authentication**: Separate authentication system for administrators

## 🎨 Theme Customization

### **Admin Command Center Theme**
- **Color Palette**: Dark navy (#1a1a2e) with red accents (#e94560)
- **Typography**: Inter font family with professional styling
- **Components**: Security-focused icons and military-inspired design elements
- **Layout**: Command center aesthetic with sophisticated controls

### **User Portal Theme**
- **Color Palette**: Light, friendly colors with blue accents
- **Typography**: Readable fonts optimized for extended reading
- **Components**: Library and book-focused iconography
- **Layout**: Welcoming, intuitive design promoting ease of use

## 📱 Responsive Design

The application adapts seamlessly across all device types:

| Device Type | Screen Size | Features |
|-------------|-------------|----------|
| **Desktop** | 1200px+ | Full feature set with expanded layouts |
| **Laptop** | 992px - 1199px | Optimized interface with all functionality |
| **Tablet** | 768px - 991px | Touch-optimized with stacked navigation |
| **Mobile** | < 768px | Streamlined interface with gesture support |

## 🧪 Testing Guide

### **Automated Testing Checklist**
- [ ] User registration with validation
- [ ] User and admin authentication flows
- [ ] Book catalog search and filtering
- [ ] Book borrowing and return processes
- [ ] Admin CRUD operations for books and users
- [ ] Database integrity and constraints
- [ ] Responsive design across devices
- [ ] Security measures and input validation

### **Manual Testing Scenarios**

1. **User Journey Testing**
   - Complete user registration process
   - Browse and search book catalog
   - Borrow and track books
   - View borrowing history

2. **Admin Workflow Testing**
   - Access admin command center
   - Manage book inventory
   - Monitor user accounts
   - Process borrowing transactions

3. **Security Testing**
   - Test input validation and sanitization
   - Verify session management
   - Check admin access restrictions
   - Validate password security

## 🚀 Deployment Options

### **IIS Deployment (Recommended for Production)**

1. **Prepare Application**
   ```bash
   # Publish from Visual Studio
   Build → Publish → Create Profile → IIS
   ```

2. **IIS Configuration**
   - Create Application Pool (.NET Framework 4.7.2)
   - Configure bindings and SSL certificates
   - Set appropriate permissions for application directory

3. **Database Deployment**
   - Deploy database to production SQL Server
   - Update connection strings for production environment
   - Run database scripts with production data

### **Azure App Service Deployment**

1. **Create Azure Resources**
   - Create App Service (.NET Framework 4.7.2)
   - Create Azure SQL Database
   - Configure connection strings in Application Settings

2. **Deploy Application**
   - Use Visual Studio Azure deployment
   - Configure continuous deployment with GitHub Actions
   - Set up monitoring and diagnostics

## 🤝 Contributing

We welcome contributions to improve the Library Management System!

### **Development Workflow**

1. **Fork** the repository to your GitHub account
2. **Clone** your fork locally
   ```bash
   git clone https://github.com/your-username/Library-Management-System.git
   ```
3. **Create** a feature branch
   ```bash
   git checkout -b feature/new-feature-name
   ```
4. **Make** your changes following our coding standards
5. **Test** thoroughly on multiple browsers and devices
6. **Commit** with descriptive messages
   ```bash
   git commit -m "Add: New feature description"
   ```
7. **Push** to your fork
   ```bash
   git push origin feature/new-feature-name
   ```
8. **Submit** a Pull Request with detailed description

### **Coding Standards**
- Follow C# naming conventions (PascalCase for methods, camelCase for variables)
- Add XML documentation comments for public methods
- Write meaningful commit messages
- Include unit tests for new functionality
- Ensure responsive design compatibility
- Maintain consistent code formatting

## 📚 Documentation

### **Additional Resources**
- [ASP.NET Web Forms Documentation](https://docs.microsoft.com/en-us/aspnet/web-forms/)
- [SQL Server Documentation](https://docs.microsoft.com/en-us/sql/sql-server/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.3/)
- [Font Awesome Icons](https://fontawesome.com/icons)

### **API Documentation**
The system includes comprehensive data access layer documentation:
- **BookDAL**: Book management operations
- **UserDAL**: User account management
- **BorrowingDAL**: Transaction processing
- **Authentication**: User and admin session management

## 🐛 Troubleshooting

### **Common Issues and Solutions**

#### **Database Connection Issues**
```
Error: Cannot open database "LibraryDB"
Solution: Verify SQL Server LocalDB is running and database exists
Command: sqllocaldb info mssqllocaldb
```

#### **Authentication Problems**
```
Issue: Unable to login with correct credentials
Solution: Check .env file configuration and password hashing
Location: Utils/UserAuth.cs and Utils/AdminAuth.cs
```

#### **Build Errors**
```
Error: Missing NuGet packages
Solution: Restore packages in Visual Studio
Steps: Right-click Solution → Restore NuGet Packages
```

## 📞 Support & Contact

### **Getting Help**

1. **Documentation**: Check this README and inline code comments
2. **Issues**: Search existing GitHub issues before creating new ones
3. **Community**: Join discussions in the repository's Discussion section
4. **Direct Contact**: Reach out for urgent matters or collaboration

### **Bug Reports**
When reporting bugs, please include:
- Steps to reproduce the issue
- Expected vs actual behavior
- Screenshots or error messages
- Browser and operating system details
- Relevant log files or database state

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for full details.

### **MIT License Summary**
- ✅ Commercial use allowed
- ✅ Modification and distribution permitted
- ✅ Private use encouraged
- ⚠️ Must include license and copyright notice
- ❌ No warranty or liability provided

## 👨‍💻 Author & Acknowledgments

### **Project Author**
**Kaustav Das**
- **GitHub**: [@kaustav3071](https://github.com/kaustav3071)
- **Repository**: [Library-Management-System](https://github.com/kaustav3071/Library-Management-System)
- **LinkedIn**: [Connect for collaboration opportunities](https://www.linkedin.com/in/kaustavdas1703/)

### **Acknowledgments**
- **Microsoft** - For the robust .NET Framework and development tools
- **Bootstrap Team** - For the excellent responsive UI framework
- **Font Awesome** - For the comprehensive icon library
- **Visual Studio Team** - For the outstanding development environment
- **Open Source Community** - For inspiration and best practices

## 🔄 Version History & Roadmap

### **Current Version: 1.0.0**
- ✅ Complete user registration and authentication system
- ✅ Professional admin command center interface
- ✅ Comprehensive book catalog and borrowing system
- ✅ Responsive design across all devices
- ✅ Database-driven architecture with SQL Server

### **Planned Features (Future Releases)**
- 📧 Email notifications for due dates and overdue books
- 📊 Advanced reporting and analytics dashboard
- 🔍 Enhanced search with filters and categories
- 📱 Mobile app development
- 🌐 Multi-language support
- 🔐 Two-factor authentication
- 📖 Digital book support (PDF viewer)
- 💳 Online payment integration for fines

---

## 🎉 Getting Started Checklist

- [ ] Clone the repository
- [ ] Set up SQL Server LocalDB
- [ ] Run database setup script
- [ ] Configure connection strings
- [ ] Build and run the application
- [ ] Test with provided credentials
- [ ] Explore both user and admin interfaces
- [ ] Customize themes and configuration as needed

**Ready to manage your library efficiently?** 🚀📚

---

*For the latest updates and releases, please check the [GitHub repository](https://github.com/kaustav3071/Library-Management-System) and star ⭐ the project if you find it useful!*
