# Education In University Project Database

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-2016%2B-blue.svg)](https://www.microsoft.com/en-us/sql-server)
[![Visual Studio](https://img.shields.io/badge/Visual%20Studio-2019%2B-purple.svg)](https://visualstudio.microsoft.com/)

A comprehensive SQL Server database project designed to manage university education systems, including students, teachers, courses, and institutional data.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Schema](#database-schema)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Database Structure](#database-structure)
- [Sample Queries](#sample-queries)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

The **Education In University Project Database** is a relational database system built for SQL Server that provides a complete solution for managing university educational data. It tracks relationships between universities, their locations, faculty members, students, and the courses they teach or attend.

### Key Features

- **University Management**: Store and manage multiple universities with their locations and student counts
- **Academic Staff Tracking**: Maintain teacher information including salaries and assigned courses
- **Student Records**: Comprehensive student data with academic performance tracking
- **Course Management**: Organize lessons/courses and their assignments
- **Relationship Mapping**: Track which students attend which courses
- **Audit Trails**: Automatic timestamping for all data changes
- **Data Integrity**: Robust foreign key constraints ensure data consistency

## 🗄️ Database Schema

The database consists of 6 interconnected tables designed to efficiently store and relate educational data:

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│  Location   │    │  University  │    │   Student   │
│             │    │              │    │             │
│ LocationId  │◄───┤ LocationId   │    │ StudentId   │
│ Address     │    │ UniversityId │◄───┤ UniversityId│
│ Area        │    │ Faculty      │    │ Name        │
│ Dates       │    │ CountStudents│    │ Surname     │
└─────────────┘    │ Dates        │    │ Birthday    │
                   └──────────────┘    │ AvgGrade    │
                                       │ Dates       │
                   ┌──────────────┐    └─────────────┘
                   │   Teacher    │           │
                   │              │           │
                   │ TeacherId    │           │
                   │ UniversityId │◄──────────┘
                   │ LessonId     │◄──┐
                   │ Name         │   │
                   │ Surname      │   │    ┌─────────────┐
                   │ Birthday     │   │    │   Lesson    │
                   │ Salary       │   │    │             │
                   │ Dates        │   └────┤ LessonId    │
                   └──────────────┘        │ LessonName  │
                                          │ Dates       │
                   ┌──────────────┐        └─────────────┘
                   │StudentLessons│               │
                   │              │               │
                   │ StudentId    │◄──────────────┘
                   │ LessonId     │◄──────────────┘
                   │ Dates        │
                   └──────────────┘
```

## 🔧 Prerequisites

Before you begin, ensure you have the following installed:

- **SQL Server 2016 or later** (Express, Standard, or Enterprise)
- **SQL Server Management Studio (SSMS)** 18.0 or later
- **Visual Studio 2019 or later** with SQL Server Data Tools (SSDT)
- **.NET Framework 4.7.2** or later

## 🚀 Installation

### Option 1: Using Visual Studio

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Kwameldx666/DatabaseBase.git
   cd DatabaseBase
   ```

2. **Open the solution**:
   - Launch Visual Studio
   - Open `DatabaseBase.sln`

3. **Build and Deploy**:
   - Right-click on the `EducationInUniversityProject` project
   - Select "Publish..."
   - Configure your target database connection
   - Click "Publish"

### Option 2: Using SQL Server Management Studio

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Kwameldx666/DatabaseBase.git
   cd DatabaseBase
   ```

2. **Execute the script**:
   - Open SQL Server Management Studio
   - Connect to your SQL Server instance
   - Open `DatabaseBase/Script.PreDeployment1.sql`
   - Execute the script (F5)

## 💡 Usage

### Basic Operations

After deployment, you can interact with the database using standard SQL commands:

```sql
-- Switch to the database
USE EducationInUniversityProject;

-- View all universities
SELECT * FROM University;

-- View all students with their universities
SELECT s.Name, s.Surname, u.Faculty 
FROM Student s
JOIN University u ON s.UniversityId = u.UniversityId;
```

### Common Scenarios

**Adding a new student**:
```sql
INSERT INTO Student (UniversityId, Name, Surname, BirthDay, AverageGrade)
VALUES (1, 'John', 'Smith', '2001-03-15', 7.5);
```

**Enrolling a student in a course**:
```sql
INSERT INTO StudentLessons (StudentId, LessonId)
VALUES (4, 1);  -- Assuming StudentId=4 and LessonId=1
```

**Adding a new teacher**:
```sql
INSERT INTO Teacher (LessonId, UniversityId, Name, Surname, BirthDay, Salary)
VALUES (1, 1, 'Dr. Sarah', 'Johnson', '1975-08-20', 60000.00);
```

## 🏗️ Database Structure

### Tables Overview

| Table Name | Purpose | Key Relationships |
|------------|---------|-------------------|
| **Location** | Store university locations | Referenced by University |
| **University** | University information | References Location, referenced by Student/Teacher |
| **Lesson** | Course/lesson catalog | Referenced by Teacher and StudentLessons |
| **Teacher** | Faculty member data | References University and Lesson |
| **Student** | Student information | References University, referenced by StudentLessons |
| **StudentLessons** | Student-course enrollment | References Student and Lesson |

### Table Details

#### Location Table
- **LocationId** (Primary Key, Auto-increment)
- **Address** (NVARCHAR(30)) - University address
- **LocationArea** (DECIMAL(8,2)) - Campus area in square meters
- **DateAdded/DateChanged** - Audit timestamps

#### University Table
- **UniversityId** (Primary Key, Auto-increment)
- **LocationId** (Foreign Key → Location)
- **Faculty** (NVARCHAR(30), NOT NULL) - Faculty name
- **CountStudents** (INT) - Number of enrolled students
- **DateAdded/DateChanged** - Audit timestamps

#### Lesson Table
- **LessonId** (Primary Key, Auto-increment)
- **LessonName** (NVARCHAR(30)) - Course name
- **DateAdded/DateChanged** - Audit timestamps

#### Teacher Table
- **TeacherId** (Primary Key, Auto-increment)
- **LessonId** (Foreign Key → Lesson)
- **UniversityId** (Foreign Key → University)
- **Name/Surname** (NVARCHAR(30)) - Teacher's full name
- **BirthDay** (DATE) - Date of birth
- **Salary** (DECIMAL(8,2)) - Monthly salary
- **DateAdded/DateChanged** - Audit timestamps

#### Student Table
- **StudentId** (Primary Key, Auto-increment)
- **UniversityId** (Foreign Key → University)
- **Name/Surname** (NVARCHAR(30)) - Student's full name
- **BirthDay** (DATE) - Date of birth
- **AverageGrade** (DECIMAL(4,2)) - Current GPA
- **DateAdded/DateChanged** - Audit timestamps

#### StudentLessons Table
- **StudentId** (Primary Key, Foreign Key → Student)
- **LessonId** (Primary Key, Foreign Key → Lesson)
- **DateAdded/DateChanged** - Audit timestamps

## 📊 Sample Queries

The database includes several pre-built analytical queries:

### 1. Popular Courses Report
```sql
-- Find lessons with more than 2 enrolled students
SELECT l.LessonName, COUNT(sl.StudentId) AS StudentCount
FROM StudentLessons sl
JOIN Lesson l ON sl.LessonId = l.LessonId
GROUP BY l.LessonName
HAVING COUNT(sl.StudentId) > 2;
```

### 2. Teacher Information Report
```sql
-- Get teacher details with their assigned courses
SELECT T.Name, T.Surname, T.Salary, T.BirthDay
FROM Teacher T
JOIN Lesson L ON T.LessonId = L.LessonId
GROUP BY T.TeacherId, T.Name, T.Surname, T.Salary, T.BirthDay
HAVING COUNT(L.LessonId) > 0;
```

### 3. High-Performing Students Report
```sql
-- Find students with GPA above 8.0
SELECT s.Name, s.Surname, s.AverageGrade
FROM Student s
JOIN University U ON s.UniversityId = U.UniversityId
GROUP BY s.Name, s.Surname, s.AverageGrade
HAVING s.AverageGrade > 8;
```

### 4. University Statistics
```sql
-- Get comprehensive university statistics
SELECT 
    u.Faculty,
    l.Address,
    u.CountStudents,
    COUNT(DISTINCT t.TeacherId) as TeacherCount,
    AVG(s.AverageGrade) as AvgStudentGrade
FROM University u
LEFT JOIN Location l ON u.LocationId = l.LocationId
LEFT JOIN Teacher t ON u.UniversityId = t.UniversityId
LEFT JOIN Student s ON u.UniversityId = s.UniversityId
GROUP BY u.UniversityId, u.Faculty, l.Address, u.CountStudents;
```

## 🤝 Contributing

We welcome contributions to improve this database project! Here's how you can help:

### Getting Started
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

### Guidelines
- Follow SQL best practices and naming conventions
- Include comments for complex queries
- Test your changes thoroughly
- Update documentation as needed
- Ensure backward compatibility

### Types of Contributions
- **Bug fixes**: Report and fix database schema issues
- **New features**: Add new tables, views, or stored procedures
- **Documentation**: Improve README, add code comments
- **Performance**: Optimize queries and indexing strategies
- **Testing**: Add data validation and test scenarios

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

## 📞 Support

If you encounter any issues or have questions about this database project:

1. **Check existing issues**: Browse [GitHub Issues](https://github.com/Kwameldx666/DatabaseBase/issues)
2. **Create a new issue**: If your problem isn't already reported
3. **Provide details**: Include SQL Server version, error messages, and steps to reproduce

## 🔄 Version History

- **v1.0.0** - Initial release with core university management functionality
  - Basic schema with 6 tables
  - Sample data and queries
  - Complete foreign key relationships

---

**Built with ❤️ for educational institutions worldwide**