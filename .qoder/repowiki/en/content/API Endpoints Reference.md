# API Endpoints Reference

<cite>
**Referenced Files in This Document**
- [server.js](file://backend/server.js)
- [app.js](file://backend/src/config/app.js)
- [database.js](file://backend/src/config/database.js)
- [models/index.js](file://backend/src/models/index.js)
- [User.js](file://backend/src/models/User.js)
- [Center.js](file://backend/src/models/Center.js)
- [Halakat.js](file://backend/src/models/Halakat.js)
- [Student.js](file://backend/src/models/Student.js)
- [StudentPlane.js](file://backend/src/models/StudentPlane.js)
- [MonthlyRating.js](file://backend/src/models/MonthlyRating.js)
- [DailyProgress.js](file://backend/src/models/DailyProgress.js)
- [Aria.js](file://backend/src/models/Aria.js)
- [Notification.js](file://backend/src/models/Notification.js)
- [Graduate.js](file://backend/src/models/Graduate.js)
- [UserController.js](file://backend/src/controllers/UserController.js)
- [CenterController.js](file://backend/src/controllers/CenterController.js)
- [HalakatController.js](file://backend/src/controllers/HalakatController.js)
- [AreaController.js](file://backend/src/controllers/AreaController.js)
- [auth.js](file://backend/src/middleware/auth.js)
- [userRoutes.js](file://backend/src/routes/userRoutes.js)
- [centerRoutes.js](file://backend/src/routes/centerRoutes.js)
- [halaqatRouts.js](file://backend/src/routes/halaqatRouts.js)
- [areaRouts.js](file://backend/src/routes/areaRouts.js)
- [studentRouts.js](file://backend/src/routes/studentRouts.js)
- [API_Endpoints_Guide.txt](file://backend/API_Endpoints_Guide.txt)
- [package.json](file://backend/package.json)
</cite>

## Update Summary
**Changes Made**
- Updated to include comprehensive Area Management API endpoints with full CRUD operations
- Added detailed authentication requirements for all area endpoints
- Enhanced endpoint documentation with proper request/response schemas
- Integrated actual AreaController implementation with comprehensive error handling
- Added area-specific operations including supervisor/mentor filtering and student counting
- Updated database schema to reflect proper Aria table naming and relationships

## Table of Contents
1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Core Components](#core-components)
4. [Architecture Overview](#architecture-overview)
5. [Database Schema and Relationships](#database-schema-and-relationships)
6. [Authentication and Authorization](#authentication-and-authorization)
7. [Complete API Endpoint Reference](#complete-api-endpoint-reference)
8. [Request/Response Examples](#requestresponse-examples)
9. [Error Handling and Status Codes](#error-handling-and-status-codes)
10. [Data Model Specifications](#data-model-specifications)
11. [Implementation Guidelines](#implementation-guidelines)
12. [Testing and Debugging](#testing-and-debugging)
13. [Troubleshooting Guide](#troubleshooting-guide)
14. [Conclusion](#conclusion)

## Introduction
This document provides a comprehensive API reference for the Khirocom RESTful service, covering all 10 database tables with their relationships, complete endpoint structure, and detailed usage guidelines. The API supports both Arabic and English languages with comprehensive CRUD operations for managing educational institutions, teachers, students, and progress tracking systems.

**Section sources**
- [API_Endpoints_Guide.txt:1-421](file://backend/API_Endpoints_Guide.txt#L1-L421)
- [server.js:1-26](file://backend/server.js#L1-L26)

## Project Structure
The backend follows a modular Express.js architecture with clear separation of concerns:

```mermaid
graph TB
Server["server.js<br/>Server Startup & Database Sync"] --> AppCfg["src/config/app.js<br/>Express App + Routes"]
AppCfg --> Auth["src/middleware/auth.js<br/>JWT Authentication"]
AppCfg --> Routes["src/routes/*.js<br/>Route Definitions"]
Routes --> Controllers["src/controllers/*.js<br/>Business Logic"]
Controllers --> Models["src/models/*.js<br/>Database Models"]
Models --> DB["src/config/database.js<br/>MySQL Connection"]
```

**Diagram sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [app.js:1-25](file://backend/src/config/app.js#L1-L25)
- [auth.js:1-25](file://backend/src/middleware/auth.js#L1-L25)

**Section sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [app.js:1-25](file://backend/src/config/app.js#L1-L25)
- [package.json:1-14](file://backend/package.json#L1-L14)

## Core Components
- **Base URL**: http://localhost:5000
- **Port**: 5000 (configurable via environment variables)
- **Database**: MySQL via Sequelize ORM
- **Authentication**: JWT-based with Bearer token support
- **Languages**: Arabic and English support
- **Current Status**: All 10 endpoints fully implemented including comprehensive Area Management

**Section sources**
- [API_Endpoints_Guide.txt:4](file://backend/API_Endpoints_Guide.txt#L4)
- [server.js:6](file://backend/server.js#L6)
- [app.js:10](file://backend/src/config/app.js#L10)

## Architecture Overview
The system implements a layered architecture with clear separation between presentation, business logic, and data access layers:

```mermaid
graph TB
Client["Client Applications"] --> Express["Express.js App"]
Express --> Auth["JWT Middleware"]
Auth --> Routes["Route Handlers"]
Routes --> Controllers["Controller Layer"]
Controllers --> Services["Business Logic"]
Services --> Models["Sequelize Models"]
Models --> Database["MySQL Database"]
```

**Diagram sources**
- [app.js:5-14](file://backend/src/config/app.js#L5-L14)
- [auth.js:4-24](file://backend/src/middleware/auth.js#L4-L24)

## Database Schema and Relationships
The system manages 10 interconnected tables with comprehensive relationships supporting educational institution management:

```mermaid
erDiagram
USERS {
int Id PK
string Name
string Username
string Password
string PhoneNumber
string AvatarUrl
enum Role
enum Gender
int Age
string EducationLevel
float Salary
string Address
datetime createdAt
datetime updatedAt
}
CENTERS {
int Id PK
string Name
string Location
int ManagerId FK
datetime createdAt
datetime updatedAt
}
ARIAS {
int Id PK
string Name
string Location
int CenterId FK
int SupervisorId FK
int MentorId FK
}
HALAKAT {
int Id PK
string Name
int studentsCount
int TeacherId FK
int AriaId FK
datetime createdAt
datetime updatedAt
}
STUDENTS {
int Id PK
string Name
enum Gender
string Username
string Password
int Age
string current_Memorization
string phoneNumber
string ImageUrl
string FatherNumber
enum Category
int User_Id FK
int HalakatId FK
datetime createdAt
datetime updatedAt
}
STUDENT_PLANES {
int Id PK
string Current_Memorization_Surah
int Current_Memorization_Ayah
decimal Daily_Memorization_Amount
string target_Memorization_Surah
int target_Memorization_Ayah
decimal Daily_Revision_Amount
string Current_Revision
string target_Revision
date StartsAt
date EndsAt
boolean ItsDone
int StudentId FK
datetime createdAt
datetime updatedAt
}
DAILY_PROGRESS {
int Id PK
date Date
string Memorization_Progress_Surah
int Memorization_Progress_Ayah
string Revision_Progress_Surah
int Revision_Progress_Ayah
enum Memorization_Level
enum Revision_Level
text Notes
int StudentId FK
datetime createdAt
datetime updatedAt
}
MONTHLY_RATING {
int Id PK
string Month
int Year
float Memoisation_degree
float Telawah_degree
float Tajweed_degree
float Motoon_degree
float Total_degree
float Average
int StudentId FK
datetime createdAt
datetime updatedAt
}
NOTIFICATIONS {
int Id PK
string Title
string Description
date Date
time Time
boolean IsRead
datetime ReadAt
int UserId FK
int StudentId FK
datetime createdAt
datetime updatedAt
}
GRADUATES {
int Id PK
datetime GraduationDate
int StudentId FK
datetime createdAt
datetime updatedAt
}
USERS ||--o{ CENTERS : "manages"
USERS ||--o{ ARIAS : "supervises"
USERS ||--o{ ARIAS : "mentors"
USERS ||--o{ HALAKAT : "teaches"
USERS ||--o{ STUDENTS : "guides"
USERS ||--o{ NOTIFICATIONS : "receives"
CENTERS ||--o{ ARIAS : "contains"
ARIAS ||--o{ HALAKAT : "hosts"
HALAKAT ||--o{ STUDENTS : "enrolls"
STUDENTS ||--o{ STUDENT_PLANES : "has"
STUDENTS ||--o{ DAILY_PROGRESS : "tracks"
STUDENTS ||--o{ MONTHLY_RATING : "rated"
STUDENTS ||--o{ NOTIFICATIONS : "receives"
STUDENTS ||--|| GRADUATES : "graduated"
```

**Diagram sources**
- [User.js:6-65](file://backend/src/models/User.js#L6-L65)
- [Center.js](file://backend/src/models/Center.js)
- [Aria.js](file://backend/src/models/Aria.js)
- [Halakat.js](file://backend/src/models/Halakat.js)
- [Student.js](file://backend/src/models/Student.js)
- [StudentPlane.js](file://backend/src/models/StudentPlane.js)
- [DailyProgress.js](file://backend/src/models/DailyProgress.js)
- [MonthlyRating.js](file://backend/src/models/MonthlyRating.js)
- [Notification.js](file://backend/src/models/Notification.js)
- [Graduate.js](file://backend/src/models/Graduate.js)

**Section sources**
- [API_Endpoints_Guide.txt:10-343](file://backend/API_Endpoints_Guide.txt#L10-L343)

## Authentication and Authorization
The system implements JWT-based authentication with role-based access control:

### Authentication Flow
1. **Login Process**: Users authenticate via `/users/login` with username and password
2. **Token Generation**: System generates JWT token with 7-day expiration
3. **Middleware Verification**: All protected routes use JWT middleware for validation
4. **Role-Based Access**: Different endpoints require specific user roles

### Supported Roles
- **admin**: Full system administration
- **مدرس**: Teacher access
- **مشرف**: Supervisor access
- **موجه**: Mentor access
- **طالب**: Student access
- **مدير**: Center manager access

### Authentication Headers
- **Authorization**: Bearer <JWT_TOKEN>
- **Content-Type**: application/json

**Section sources**
- [UserController.js:96-132](file://backend/src/controllers/UserController.js#L96-L132)
- [auth.js:4-24](file://backend/src/middleware/auth.js#L4-L24)
- [User.js:39-43](file://backend/src/models/User.js#L39-L43)

## Complete API Endpoint Reference

### User Management Endpoints

#### Authentication
- **POST /users/login**
  - **Description**: Authenticate user and generate JWT token
  - **Authentication**: None
  - **Request Body**: `{ Username: string, Password: string }`
  - **Response**: `{ message: string, userId: number, Name: string, PhoneNumber: string, Role: string, token: string }`
  - **Status Codes**: 200 (success), 400 (invalid credentials), 500 (server error)

- **POST /users/adduser**
  - **Description**: Register new user (admin only)
  - **Authentication**: Required (admin)
  - **Request Body**: `{ Username: string, Password: string, Name: string, PhoneNumber: string, Gender: string, Age: number, EducationLevel: string, Role: string, Salary?: number, Address?: string, AvtarUrl?: string }`
  - **Response**: `{ message: string, user: object }`
  - **Status Codes**: 201 (created), 500 (server error)

#### User Operations
- **GET /users/getusers**
  - **Description**: Retrieve all users
  - **Authentication**: Required
  - **Response**: `{ message: string, users: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /users/getuserbyname**
  - **Description**: Search user by name
  - **Authentication**: Required
  - **Request Body**: `{ Name: string }`
  - **Response**: `{ message: string, user: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **PUT /users/updateuser**
  - **Description**: Update user information (admin only)
  - **Authentication**: Required (admin)
  - **Request Body**: `{ Id: number, ... }` (any user fields)
  - **Response**: `{ message: string, user: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **PUT /users/updateme**
  - **Description**: Update current user profile
  - **Authentication**: Required
  - **Request Body**: `{ Name?: string, Username?: string, Password?: string, PhoneNumber?: string, AvtarUrl?: string, Gender?: string, Age?: number, EducationLevel?: string, Address?: string }`
  - **Response**: `{ message: string, user: object }`
  - **Status Codes**: 200 (success), 400 (no fields to update), 404 (user not found), 500 (server error)

- **GET /users/getusersbyroleandareaid**
  - **Description**: Get users by role and area ID
  - **Authentication**: Required
  - **Request Body**: `{ Role: string, AreaId: number }`
  - **Response**: `{ message: string, users: array }`
  - **Status Codes**: 200 (success), 500 (server error)

### Center Management Endpoints

#### Center Operations
- **POST /centers/addCenter**
  - **Description**: Create new center
  - **Authentication**: Required
  - **Request Body**: `{ Name: string, Location: string, ManagerId: number }`
  - **Response**: `{ message: string, center: object }`
  - **Status Codes**: 201 (created), 500 (server error)

- **GET /centers/getCenters**
  - **Description**: Retrieve all centers with manager information
  - **Authentication**: Required
  - **Response**: `{ message: string, centers: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /centers/getCenterById**
  - **Description**: Get center by ID
  - **Authentication**: Required
  - **Request Body**: `{ id: number }`
  - **Response**: `{ message: string, center: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /centers/getCenterbymanagerid**
  - **Description**: Get centers managed by current user
  - **Authentication**: Required
  - **Response**: `{ message: string, centers: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **PUT /centers/updateCenter**
  - **Description**: Update center information
  - **Authentication**: Required
  - **Request Body**: `{ id: number, ... }` (any center fields)
  - **Response**: `{ message: string, center: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **DELETE /centers/deleteCenter**
  - **Description**: Delete center
  - **Authentication**: Required
  - **Request Body**: `{ id: number }`
  - **Response**: `{ message: string, center: object }`
  - **Status Codes**: 200 (success), 500 (server error)

### Halakat (Class) Management Endpoints

#### Halakat Operations
- **GET /halaqat/getallhalaqat**
  - **Description**: Get all halakat with student count
  - **Authentication**: Required
  - **Response**: `{ message: string, halaqat: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /halaqat/gethalaqahbyteacherid**
  - **Description**: Get halakat by teacher ID
  - **Authentication**: Required
  - **Request Body**: `{ TeacherId: number }`
  - **Response**: `{ message: string, halaqah: object }`
  - **Status Codes**: 200 (success), 404 (not found), 500 (server error)

- **PUT /halaqat/updatehalaqah**
  - **Description**: Update halakat
  - **Authentication**: Required
  - **Request Body**: `{ Id: number, ... }` (any halakat fields)
  - **Response**: `{ message: string, halaqah: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **POST /halaqat/addhalaqah**
  - **Description**: Create new halakat
  - **Authentication**: Required
  - **Request Body**: `{ Name: string, studentsGender: string, type: string, TeacherId: number, AriaId: number }`
  - **Response**: `{ message: string, halaqah: object }`
  - **Status Codes**: 201 (created), 500 (server error)

- **GET /halaqat/gethalaqahbysarch**
  - **Description**: Search halakat by name
  - **Authentication**: Required
  - **Request Body**: `{ Name: string }`
  - **Response**: `{ message: string, halaqat: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /halaqat/gethalaqahbyid**
  - **Description**: Get halakat by ID
  - **Authentication**: Required
  - **Request Body**: `{ Id: number }`
  - **Response**: `{ message: string, halaqah: object }`
  - **Status Codes**: 200 (success), 404 (not found), 500 (server error)

- **GET /halaqat/gethalaqahbyareaid**
  - **Description**: Get halakat by area ID
  - **Authentication**: Required
  - **Request Body**: `{ AriaId: number }`
  - **Response**: `{ message: string, halaqat: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **DELETE /halaqat/deletehalaqah**
  - **Description**: Delete halakat
  - **Authentication**: Required
  - **Request Body**: `{ Id: number }`
  - **Response**: `{ message: string, halaqah: object }`
  - **Status Codes**: 200 (success), 500 (server error)

### Area Management Endpoints

#### Area Operations
- **GET /areas/getallareas**
  - **Description**: Get all areas with supervisor and mentor information
  - **Authentication**: Required
  - **Response**: `{ message: string, areas: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /areas/getareabyid**
  - **Description**: Get area by ID with supervisor and mentor information
  - **Authentication**: Required
  - **Request Body**: `{ id: number }`
  - **Response**: `{ message: string, area: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **POST /areas/addarea**
  - **Description**: Create new area
  - **Authentication**: Required
  - **Request Body**: `{ Name: string, Location: string, CenterId: number, SupervisorId: number, MentorId: number }`
  - **Response**: `{ message: string, area: object }`
  - **Status Codes**: 201 (created), 500 (server error)

- **PUT /areas/updatearea**
  - **Description**: Update area information
  - **Authentication**: Required
  - **Request Body**: `{ id: number, ... }` (any area fields)
  - **Response**: `{ message: string, area: object }`
  - **Status Codes**: 200 (success), 500 (server error)

- **DELETE /areas/deletearea**
  - **Description**: Delete area
  - **Authentication**: Required
  - **Request Body**: `{ id: number }`
  - **Response**: `{ message: string, area: object }`
  - **Status Codes**: 200 (success), 500 (server error)

#### Area Filtering and Analysis
- **GET /areas/getareasbysupervisor**
  - **Description**: Get areas supervised by specific supervisor
  - **Authentication**: Required
  - **Query Parameters**: `id: number`
  - **Response**: `{ message: string, areas: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /areas/getareasbymentor**
  - **Description**: Get areas mentored by specific mentor
  - **Authentication**: Required
  - **Request Body**: `{ id: number }`
  - **Response**: `{ message: string, areas: array }`
  - **Status Codes**: 200 (success), 500 (server error)

- **GET /areas/getallstudentscount**
  - **Description**: Get total student count in specific area
  - **Authentication**: Required
  - **Request Body**: `{ id: number }` or Query Parameter: `id: number`
  - **Response**: `{ message: string, studentscount: number }`
  - **Status Codes**: 200 (success), 400 (missing area ID), 404 (area not found), 500 (server error)

- **GET /areas/getareabyname**
  - **Description**: Search areas by name (partial match)
  - **Authentication**: Required
  - **Request Body**: `{ name: string }`
  - **Response**: `{ message: string, area: array }`
  - **Status Codes**: 200 (success), 500 (server error)

**Section sources**
- [areaRouts.js:8-17](file://backend/src/routes/areaRouts.js#L8-L17)
- [AreaController.js:8-204](file://backend/src/controllers/AreaController.js#L8-L204)

## Request/Response Examples

### Authentication Examples

#### Login Request
```
POST http://localhost:5000/users/login
Content-Type: application/json

{
    "Username": "ahmed123",
    "Password": "password123"
}
```

**Response:**
```json
{
    "message": "Login successful",
    "userId": 1,
    "Name": "Ahmed Mohamed",
    "PhoneNumber": "0501234567",
    "Role": "مشرف",
    "AvatarUrl": null,
    "Gender": "ذكر",
    "Age": 25,
    "EducationLevel": "بكالوريوس",
    "Address": "الرياض",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### User Registration
```
POST http://localhost:5000/users/adduser
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Content-Type: application/json

{
    "Username": "newuser",
    "Password": "password123",
    "Name": "أحمد محمد",
    "PhoneNumber": "0501234567",
    "Gender": "ذكر",
    "Age": 25,
    "EducationLevel": "بكالوريوس",
    "Role": "مشرف"
}
```

**Response:**
```json
{
    "message": "تم إضافة أحمد محمد بنجاح",
    "user": {
        "Id": 2,
        "Username": "newuser",
        "Name": "أحمد محمد",
        "PhoneNumber": "0501234567",
        "Gender": "ذكر",
        "Age": 25,
        "EducationLevel": "بكالوريوس",
        "Role": "مشرف",
        "Salary": 0,
        "Address": "",
        "AvtarUrl": "",
        "createdAt": "2026-03-19T10:30:00.000Z",
        "updatedAt": "2026-03-19T10:30:00.000Z"
    }
}
```

#### Area Management
```
POST http://localhost:5000/areas/addarea
Authorization: Bearer <token>
Content-Type: application/json

{
    "Name": "المنطقة الشرقية",
    "Location": "الدمام",
    "CenterId": 1,
    "SupervisorId": 2,
    "MentorId": 3
}
```

**Response:**
```json
{
    "message": "تم إضافة المنطقة",
    "area": {
        "Id": 1,
        "Name": "المنطقة الشرقية",
        "Location": "الدمام",
        "CenterId": 1,
        "SupervisorId": 2,
        "MentorId": 3,
        "createdAt": "2026-03-19T10:30:00.000Z",
        "updatedAt": "2026-03-19T10:30:00.000Z"
    }
}
```

#### Area Student Count
```
GET http://localhost:5000/areas/getallstudentscount?id=1
Authorization: Bearer <token>
Content-Type: application/json
```

**Response:**
```json
{
    "message": "تم الحصول على عدد الطلاب",
    "studentscount": 45
}
```

**Section sources**
- [API_Endpoints_Guide.txt:377-415](file://backend/API_Endpoints_Guide.txt#L377-L415)
- [UserController.js:96-132](file://backend/src/controllers/UserController.js#L96-L132)
- [AreaController.js:57-94](file://backend/src/controllers/AreaController.js#L57-L94)

## Error Handling and Status Codes

### Common HTTP Status Codes
- **200 OK**: Successful GET, PUT, DELETE operations
- **201 Created**: Successful POST operations
- **400 Bad Request**: Invalid request data, validation errors
- **401 Unauthorized**: Missing or invalid JWT token
- **403 Forbidden**: Insufficient permissions for requested operation
- **404 Not Found**: Resource not found
- **500 Internal Server Error**: Unexpected server errors

### Error Response Format
```json
{
    "error": "Error message describing the problem",
    "stack": "Optional stack trace for debugging"
}
```

### Authentication Errors
- **Missing Authorization Header**: 401 - "invalid token"
- **Invalid JWT Token**: 401 - "invalid token"
- **User Not Found**: 401 - "user not found"

### Business Logic Errors
- **Area Not Found**: 404 - "المنطقة غير موجودة"
- **Employee Not Found**: 404 - "الموظف غير موجود"
- **No Fields to Update**: 400 - "No fields to update"
- **Invalid Credentials**: 400 - "Invalid credentials"
- **Missing Area ID**: 400 - "معرّف المنطقة مطلوب"

**Section sources**
- [auth.js:7-23](file://backend/src/middleware/auth.js#L7-L23)
- [UserController.js:37-50](file://backend/src/controllers/UserController.js#L37-L50)
- [AreaController.js:72-89](file://backend/src/controllers/AreaController.js#L72-L89)

## Data Model Specifications

### Users Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Name`: STRING, Required
- `Username`: STRING, Required
- `Password`: STRING(255), Required
- `PhoneNumber`: STRING, Required
- `AvatarUrl`: STRING, Optional
- `Role`: ENUM, Required (admin, مدرس, مشرف, موجه, طالب, مدير)
- `Gender`: ENUM, Required (ذكر, أنثى)
- `Age`: INTEGER, Required
- `EducationLevel`: STRING(256), Required
- `Salary`: FLOAT, Required (default: 0)
- `Address`: STRING(256), Required

**Relationships:**
- One-to-one with Centers (manager)
- One-to-one with Aria (supervisor)
- One-to-one with Aria (mentor)
- One-to-many with Halakat (teacher)
- One-to-many with Students
- One-to-many with Notifications

### Centers Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Name`: STRING, Required
- `Location`: STRING, Required
- `ManagerId`: INTEGER, Foreign Key to Users.Id

**Relationships:**
- Belongs to Users (manager)
- Has many Aria

### Aria Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Name`: STRING, Required
- `Location`: STRING, Required
- `CenterId`: INTEGER, Foreign Key to Centers.Id
- `SupervisorId`: INTEGER, Foreign Key to Users.Id
- `MentorId`: INTEGER, Foreign Key to Users.Id

**Relationships:**
- Belongs to Centers
- Belongs to Users (supervisor)
- Belongs to Users (mentor)
- Has many Halakat

### Halakat Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Name`: STRING, Required
- `studentsCount`: INTEGER, Required
- `TeacherId`: INTEGER, Foreign Key to Users.Id
- `AriaId`: INTEGER, Foreign Key to Aria.Id

**Relationships:**
- Belongs to Users (teacher)
- Belongs to Aria
- Has many Students

### Students Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Name`: STRING, Required
- `Gender`: ENUM, Required (ذكر, أنثى)
- `Username`: STRING, Required
- `Password`: STRING(256), Required (default: "12345")
- `Age`: INTEGER, Required
- `current_Memorization`: STRING, Required
- `phoneNumber`: STRING, Required
- `ImageUrl`: STRING, Optional
- `FatherNumber`: STRING, Required
- `Category`: ENUM, Required (اطفال, أقل من 5 أجزاء, 5 أجزاء, 10 أجزاء, 15 جزء, 20 جزء, 25 جزء, المصجف كامل)
- `User_Id`: INTEGER, Foreign Key to Users.Id
- `HalakatId`: INTEGER, Foreign Key to Halakat.Id

**Relationships:**
- Belongs to Users
- Belongs to Halakat
- Has many StudentPlanes
- Has many DailyProgress
- Has many MonthlyRatings
- Has many Notifications
- Has one Graduate

### StudentPlanes Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Current_Memorization_Surah`: STRING, Required
- `Current_Memorization_Ayah`: INTEGER, Required
- `Daily_Memorization_Amount`: DECIMAL(10,2), Required
- `target_Memorization_Surah`: STRING, Required
- `target_Memorization_Ayah`: INTEGER, Required
- `Daily_Revision_Amount`: DECIMAL(10,2), Required
- `Current_Revision`: STRING, Required
- `target_Revision`: STRING, Required
- `StartsAt`: DATE, Required
- `EndsAt`: DATE, Required
- `ItsDone`: BOOLEAN, Required (default: false)
- `StudentId`: INTEGER, Foreign Key to Students.Id

**Relationships:**
- Belongs to Students

### DailyProgress Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Date`: DATE, Required
- `Memorization_Progress_Surah`: STRING, Required
- `Memorization_Progress_Ayah`: INTEGER, Required
- `Revision_Progress_Surah`: STRING, Required
- `Revision_Progress_Ayah`: INTEGER, Required
- `Memorization_Level`: ENUM, Required (ضعيف, مقبول, جيد, جيد جدا, ممتاز)
- `Revision_Level`: ENUM, Required (ضعيف, مقبول, جيد, جيد جدا, ممتاز)
- `Notes`: TEXT, Optional
- `StudentId`: INTEGER, Foreign Key to Students.Id

**Relationships:**
- Belongs to Students

### MonthlyRating Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Month`: STRING, Required
- `Year`: INTEGER, Required
- `Memoisation_degree`: FLOAT, Required (0-100)
- `Telawah_degree`: FLOAT, Required (0-100)
- `Tajweed_degree`: FLOAT, Required (0-60)
- `Motoon_degree`: FLOAT, Required (0-400)
- `Total_degree`: FLOAT, Required
- `Average`: FLOAT, Required
- `StudentId`: INTEGER, Foreign Key to Students.Id

**Relationships:**
- Belongs to Students

### Notifications Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `Title`: STRING, Required
- `Description`: STRING, Required
- `Date`: DATE, Required
- `Time`: TIME, Required
- `IsRead`: BOOLEAN, Required (default: false)
- `ReadAt`: DATETIME, Optional
- `UserId`: INTEGER, Foreign Key to Users.Id
- `StudentId`: INTEGER, Foreign Key to Students.Id

**Relationships:**
- Belongs to Users
- Belongs to Students

### Graduates Table
**Columns:**
- `Id`: INTEGER, Primary Key, Auto Increment
- `GraduationDate`: DATETIME, Required
- `StudentId`: INTEGER, Foreign Key to Students.Id

**Relationships:**
- Belongs to Students (One-to-One)

**Section sources**
- [API_Endpoints_Guide.txt:27-319](file://backend/API_Endpoints_Guide.txt#L27-L319)
- [User.js:6-65](file://backend/src/models/User.js#L6-L65)
- [Aria.js:4-58](file://backend/src/models/Aria.js#L4-L58)

## Implementation Guidelines

### Authentication Best Practices
1. **Token Storage**: Store JWT tokens securely using HttpOnly cookies or secure storage mechanisms
2. **Token Expiration**: Tokens expire after 7 days as configured in the login controller
3. **Header Format**: Always use "Bearer <token>" format for Authorization headers
4. **Error Handling**: Implement proper error handling for expired or invalid tokens

### Rate Limiting and Security
1. **Input Validation**: All endpoints validate input data types and constraints
2. **SQL Injection Prevention**: Sequelize ORM automatically handles parameter binding
3. **Password Security**: Passwords are hashed using bcrypt with 10 rounds
4. **Role-Based Access**: Implement proper authorization checks for admin-only endpoints

### Database Design Principles
1. **Foreign Key Constraints**: All relationships maintain referential integrity
2. **Indexing Strategy**: Consider adding indexes on frequently queried columns
3. **Data Types**: Use appropriate data types for optimal storage and performance
4. **Default Values**: Many fields have sensible defaults to ensure data consistency

### API Versioning
- **Current Version**: v1 (embedded in base URL)
- **Future Enhancement**: Consider implementing version-specific endpoints for backward compatibility

### Area Management Specific Guidelines
1. **Area Creation**: Ensure CenterId, SupervisorId, and MentorId are valid foreign keys
2. **Area Filtering**: Use proper query parameters for supervisor/mentor filtering
3. **Student Counting**: Implement efficient joins for counting students across halakat
4. **Name Search**: Use LIKE operator for partial name matching with proper escaping

**Section sources**
- [UserController.js:59-76](file://backend/src/controllers/UserController.js#L59-L76)
- [AreaController.js:57-204](file://backend/src/controllers/AreaController.js#L57-L204)
- [auth.js:11](file://backend/src/middleware/auth.js#L11)

## Testing and Debugging

### Development Setup
1. **Environment Variables**: Configure `.env` file with database credentials and JWT secret
2. **Database Migration**: Run `sequelize.sync({ alter: true })` to create/update tables
3. **Server Start**: Use `npm start` to launch the server on configured port

### Testing Strategies
1. **Unit Testing**: Test individual controller functions with mock data
2. **Integration Testing**: Test complete request/response cycles
3. **Authentication Testing**: Verify JWT token generation and validation
4. **Database Testing**: Test CRUD operations with test database

### Debugging Tools
1. **Logging**: Server logs database connections and synchronization status
2. **Error Tracking**: Centralized error handling with detailed error messages
3. **Request Monitoring**: Track API usage patterns and performance metrics
4. **Database Monitoring**: Monitor query performance and optimize slow queries

### Common Issues and Solutions
1. **Database Connection Failed**: Verify database credentials and network connectivity
2. **JWT Token Invalid**: Check token format and expiration time
3. **Missing Required Fields**: Ensure all mandatory fields are provided in requests
4. **Permission Denied**: Verify user role and required authorization level
5. **Area Foreign Key Errors**: Ensure CenterId, SupervisorId, and MentorId reference valid records

**Section sources**
- [server.js:8-23](file://backend/server.js#L8-L23)
- [auth.js:10-23](file://backend/src/middleware/auth.js#L10-L23)

## Troubleshooting Guide

### Server Startup Issues
- **Problem**: Server fails to start
- **Solution**: Check database connection credentials and verify MySQL server is running
- **Verification**: Look for "Database connected" and "Database synced successfully!" in logs

### Authentication Problems
- **Problem**: 401 Unauthorized responses
- **Solution**: Verify JWT token format and ensure Authorization header uses "Bearer" prefix
- **Debug**: Check JWT_SECRET environment variable and token expiration

### Database Synchronization
- **Problem**: Tables not created or updated
- **Solution**: Verify Sequelize configuration and database permissions
- **Check**: Look for "Registered models" and synchronization success messages

### API Endpoint Issues
- **Problem**: 404 Not Found for implemented endpoints
- **Solution**: Verify route prefixes (/users, /centers, /halaqat, /areas, /students)
- **Debug**: Check route definitions and controller exports

### Data Validation Errors
- **Problem**: 400 Bad Request responses
- **Solution**: Ensure all required fields are provided and data types match model definitions
- **Check**: Validate ENUM values match allowed options (e.g., Gender, Role, Category)

### Area Management Issues
- **Problem**: Area creation failing with foreign key errors
- **Solution**: Verify CenterId, SupervisorId, and MentorId reference existing records
- **Debug**: Check user roles are correct (must be مشرف for SupervisorId, موجه for MentorId)
- **Issue**: Area deletion failing due to dependent halakat
- **Solution**: Delete associated halakat before deleting area

**Section sources**
- [server.js:8-23](file://backend/server.js#L8-L23)
- [auth.js:7-23](file://backend/src/middleware/auth.js#L7-L23)
- [AreaController.js:72-89](file://backend/src/controllers/AreaController.js#L72-L89)

## Conclusion
The Khirocom API provides a comprehensive RESTful interface for educational institution management with full Arabic and English support. The current implementation covers all 10 planned endpoints with robust authentication, comprehensive data models, and detailed error handling. The system is designed for scalability with clear separation of concerns and follows modern API development best practices.

Key strengths of the current implementation:
- Complete JWT-based authentication system
- Comprehensive Arabic and English language support
- Well-defined data models with proper relationships
- Extensive error handling and validation
- Modular architecture supporting future expansion
- Ready for production deployment with proper security measures
- Full Area Management API with comprehensive CRUD operations

Future enhancements could include:
- Advanced filtering and pagination for large datasets
- Real-time notifications and WebSocket integration
- Comprehensive API documentation with OpenAPI/Swagger
- Automated testing suite with continuous integration
- Performance monitoring and optimization tools
- Enhanced area analytics and reporting capabilities

**Section sources**
- [API_Endpoints_Guide.txt:345-375](file://backend/API_Endpoints_Guide.txt#L345-L375)
- [server.js:18](file://backend/server.js#L18)