# Feature Modules

<cite>
**Referenced Files in This Document**
- [server.js](file://backend/server.js)
- [app.js](file://backend/src/config/app.js)
- [database.js](file://backend/src/config/database.js)
- [models/index.js](file://backend/src/models/index.js)
- [Graduate.js](file://backend/src/models/Graduate.js)
- [User.js](file://backend/src/models/User.js)
- [Center.js](file://backend/src/models/Center.js)
- [Halakat.js](file://backend/src/models/Halakat.js)
- [Student.js](file://backend/src/models/Student.js)
- [MonthlyRating.js](file://backend/src/models/MonthlyRating.js)
- [DailyProgress.js](file://backend/src/models/DailyProgress.js)
- [Aria.js](file://backend/src/models/Aria.js)
- [AreaController.js](file://backend/src/controllers/AreaController.js)
- [areaRouts.js](file://backend/src/routes/areaRouts.js)
- [userRoutes.js](file://backend/src/routes/userRoutes.js)
- [centerRoutes.js](file://backend/src/routes/centerRoutes.js)
- [halaqatRouts.js](file://backend/src/routes/halaqatRouts.js)
- [studentRouts.js](file://backend/src/routes/studentRouts.js)
- [auth.js](file://backend/src/middleware/auth.js)
- [package.json](file://backend/package.json)
</cite>

## Update Summary
**Changes Made**
- Added new Area Management System feature module with comprehensive CRUD operations
- Integrated Area model with associations to Center, Supervisor, and Mentor users
- Implemented area-based student counting functionality
- Added area search by name and supervisor/mentor filtering capabilities
- Updated architecture diagrams to reflect the new area management capability
- Enhanced routing structure with dedicated area endpoints

## Table of Contents
1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Core Components](#core-components)
4. [Architecture Overview](#architecture-overview)
5. [Detailed Component Analysis](#detailed-component-analysis)
6. [Dependency Analysis](#dependency-analysis)
7. [Performance Considerations](#performance-considerations)
8. [Troubleshooting Guide](#troubleshooting-guide)
9. [Conclusion](#conclusion)
10. [Appendices](#appendices)

## Introduction
This document describes the feature modules and implementation architecture for the Khirocom system. It focuses on the complete feature set and how the system is structured around an MVC-like pattern, with models representing the data layer, routes and controllers handling API endpoints and business logic, and middleware processing requests. The documented features include User Management, Center Administration, Teaching Group Management, Student Tracking, Daily Progress Monitoring, Monthly Rating System, Area Management System, Graduate Tracking System, and Learning Plan Management. The document also explains feature interdependencies, data flows, practical usage scenarios, and guidelines for extending and integrating new features.

## Project Structure
The backend follows a layered structure:
- Configuration: Express application and database initialization
- Models: Sequelize ORM models with associations
- Routes: API endpoint definitions
- Controllers: Business logic handlers
- Middleware: Request processing
- Tests: Test suite

```mermaid
graph TB
subgraph "Backend"
CFG["Express App<br/>server.js -> app.js"]
DB["Database Config<br/>database.js"]
MODELS["Models & Associations<br/>models/index.js"]
ROUTES["Routes<br/>userRoutes.js, centerRoutes.js, halaqatRouts.js, areaRouts.js, studentRouts.js"]
CONTROLLERS["Controllers<br/>AreaController.js, UserController.js, CenterController.js, HalakatController.js, StudentController.js"]
MIDDLEWARE["Middleware<br/>auth.js"]
end
CFG --> ROUTES
ROUTES --> CONTROLLERS
CONTROLLERS --> MODELS
MODELS --> DB
CFG --> DB
ROUTES --> MIDDLEWARE
```

**Diagram sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [app.js](file://backend/src/config/app.js)
- [database.js](file://backend/src/config/database.js)
- [models/index.js:1-91](file://backend/src/models/index.js#L1-L91)
- [areaRouts.js:1-20](file://backend/src/routes/areaRouts.js#L1-L20)
- [userRoutes.js:1-17](file://backend/src/routes/userRoutes.js#L1-L17)
- [centerRoutes.js:1-14](file://backend/src/routes/centerRoutes.js#L1-L14)
- [halaqatRouts.js:1-18](file://backend/src/routes/halaqatRouts.js#L1-L18)
- [studentRouts.js:1-15](file://backend/src/routes/studentRouts.js#L1-L15)

**Section sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [package.json:1-14](file://backend/package.json#L1-L14)

## Core Components
This section outlines the core components and their responsibilities within the system.

- Express Application
  - Initializes the web server and loads environment variables
  - Starts the server on the configured port
  - Synchronizes models with the database

- Database Configuration
  - Provides connection configuration for Sequelize
  - Centralizes database credentials and options

- Models and Associations
  - Define entities and relationships among Users, Centers, Teaching Groups (Halakat), Areas, Students, Monthly Ratings, Daily Progress, and Graduates
  - Enforce referential integrity via foreign keys
  - Include validation rules for numeric fields and enumerations
  - **New**: Area model provides geographic and administrative boundaries with supervisor and mentor assignments

- Routing and Controllers
  - API endpoint definitions for user management, center administration, teaching group management, area management, and student management
  - Will depend on models for data access and middleware for request processing

- Middleware
  - Authentication middleware for securing API endpoints
  - Request processing and validation

**Section sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [database.js](file://backend/src/config/database.js)
- [models/index.js:1-91](file://backend/src/models/index.js#L1-L91)
- [auth.js](file://backend/src/middleware/auth.js)

## Architecture Overview
The system architecture centers on an MVC-like separation of concerns:
- Models: Represent domain entities and relationships
- Controllers: Encapsulate business logic and coordinate model operations
- Routes: Expose endpoints for client consumption
- Middleware: Pre-process requests and post-process responses
- Database: Persist and retrieve data using Sequelize

```mermaid
graph TB
CLIENT["Client Applications"]
APP["Express App"]
MW["Middleware"]
CTRL["Controllers"]
SRV["Services / Business Logic"]
MDL["Models"]
DB["Database"]
CLIENT --> APP
APP --> MW
MW --> CTRL
CTRL --> SRV
SRV --> MDL
MDL --> DB
```

## Detailed Component Analysis

### User Management
- Purpose: Manage users with roles (admin, teacher, supervisor, manager)
- Responsibilities:
  - Create, update, delete, and list users
  - Authenticate and authorize actions based on role
  - Link users to centers and teaching groups
- Data Model: User entity with identity, credentials, contact info, avatar, and role
- Interactions:
  - Users manage Centers (one-to-many)
  - Users teach Halakat (one-to-many)
  - Users supervise Areas (one-to-many)
  - Users mentor Areas (one-to-many)
  - Users are linked to Centers and Halakat via foreign keys

```mermaid
classDiagram
class User {
+integer Id
+string Name
+string Username
+string Email
+string PhoneNumber
+string Avatar
+enum Role
}
class Center {
+integer Id
+string Name
+string Location
+integer ManagerId
}
class Halakat {
+integer Id
+string Name
+integer studentsCount
+integer TeacherId
+integer CenterId
}
class Aria {
+integer Id
+string Name
+string Location
+integer CenterId
+integer SupervisorId
+integer MentorId
}
User "1" --> "many" Center : "manages"
User "1" --> "many" Halakat : "teaches"
User "1" --> "many" Aria : "supervises"
User "1" --> "many" Aria : "mentors"
Center "1" --> "many" Halakat : "contains"
Center "1" --> "many" Aria : "contains"
```

**Diagram sources**
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)

**Section sources**
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [models/index.js:21-27](file://backend/src/models/index.js#L21-L27)
- [models/index.js:33-39](file://backend/src/models/index.js#L33-L39)

### Center Administration
- Purpose: Manage educational centers and their administrators
- Responsibilities:
  - Create, update, delete, and list centers
  - Assign managers (users) to centers
  - Track center location and associated halakat and areas
- Data Model: Center entity with name, location, and manager reference
- Interactions:
  - Center belongs to a User (manager)
  - Center contains many Halakat instances
  - Center contains many Area instances

```mermaid
classDiagram
class Center {
+integer Id
+string Name
+string Location
+integer ManagerId
}
class User {
+integer Id
+enum Role
}
class Halakat {
+integer Id
+integer CenterId
}
class Aria {
+integer Id
+integer CenterId
}
Center --> User : "managed by"
Center "1" --> "many" Halakat : "contains"
Center "1" --> "many" Aria : "contains"
```

**Diagram sources**
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)

**Section sources**
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [models/index.js:16-18](file://backend/src/models/index.js#L16-L18)

### Area Management System
- Purpose: Manage geographic and administrative areas within centers
- Responsibilities:
  - Create, update, delete, and list areas
  - Assign supervisors and mentors (users) to areas
  - Track area location and center association
  - Count students enrolled in areas
  - Filter areas by supervisor, mentor, or name
- Data Model: Area entity with name, location, center reference, supervisor reference, and mentor reference
- Interactions:
  - Area belongs to a Center
  - Area belongs to a User (supervisor)
  - Area belongs to a User (mentor)
  - Area contains many Halakat instances
  - Supports area-based student counting

```mermaid
classDiagram
class Aria {
+integer Id
+string Name
+string Location
+integer CenterId
+integer SupervisorId
+integer MentorId
}
class Center {
+integer Id
}
class User {
+integer Id
}
class Halakat {
+integer Id
+integer AriaId
}
class Student {
+integer Id
+integer HalakatId
}
Aria --> Center : "located in"
Aria --> User : "supervised by"
Aria --> User : "mentored by"
Aria "1" --> "many" Halakat : "contains"
Halakat "1" --> "many" Student : "enrolls"
```

**Diagram sources**
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)

**Section sources**
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)
- [AreaController.js:1-205](file://backend/src/controllers/AreaController.js#L1-L205)
- [areaRouts.js:1-20](file://backend/src/routes/areaRouts.js#L1-L20)
- [models/index.js:29-39](file://backend/src/models/index.js#L29-L39)

### Teaching Group Management
- Purpose: Manage teaching groups (classes) within centers and areas
- Responsibilities:
  - Create, update, delete, and list halakat
  - Assign teachers (users), centers, and areas
  - Track student counts per group
- Data Model: Halakat entity with name, student count, teacher, center, and area references
- Interactions:
  - Halakat belongs to a User (teacher)
  - Halakat belongs to a Center
  - Halakat belongs to an Area
  - Halakat contains many Students

```mermaid
classDiagram
class Halakat {
+integer Id
+string Name
+integer studentsCount
+integer TeacherId
+integer CenterId
+integer AriaId
}
class User {
+integer Id
}
class Center {
+integer Id
}
class Aria {
+integer Id
}
class Student {
+integer Id
+integer HalakatId
}
Halakat --> User : "taught by"
Halakat --> Center : "located at"
Halakat --> Aria : "assigned to"
Halakat "1" --> "many" Student : "enrolls"
```

**Diagram sources**
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)

**Section sources**
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [models/index.js:29-31](file://backend/src/models/index.js#L29-L31)

### Student Tracking
- Purpose: Track student profiles and enrollment in halakat
- Responsibilities:
  - Create, update, delete, and list students
  - Capture personal details, category, and parent/guardian contact
  - Enroll students in halakat groups
- Data Model: Student entity with personal info, category enumeration, and halakat reference
- Interactions:
  - Student belongs to a Halakat
  - Student has many Monthly Ratings and Daily Progress entries
  - **New**: Student belongs to an Area through halakat assignment
  - **New**: Student has one Graduate record for completion tracking

```mermaid
classDiagram
class Student {
+integer Id
+string Name
+integer Age
+string current_Memorization
+string phoneNumber
+string ImageUrl
+string FatherNumber
+enum Category
+integer HalakatId
}
class Halakat {
+integer Id
+integer AriaId
}
class Aria {
+integer Id
}
class MonthlyRating {
+integer Id
+integer StudentId
}
class DailyProgress {
+integer Id
+date Date
+integer StudentId
}
class Graduate {
+integer Id
+date GraduationDate
+integer StudentId
}
Student --> Halakat : "enrolled in"
Halakat --> Aria : "belongs to"
Student "1" --> "many" MonthlyRating : "rated in"
Student "1" --> "many" DailyProgress : "tracked in"
Student "1" --> "1" Graduate : "graduated"
```

**Diagram sources**
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)
- [Graduate.js:1-37](file://backend/src/models/Graduate.js#L1-L37)

**Section sources**
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)
- [models/index.js:41-55](file://backend/src/models/index.js#L41-L55)
- [models/index.js:70-72](file://backend/src/models/index.js#L70-L72)

### Daily Progress Monitoring
- Purpose: Record daily memorization and revision progress
- Responsibilities:
  - Log daily progress with surah, ayah, and level indicators
  - Store notes and associate with a student
- Data Model: DailyProgress entity with date, progress metrics, levels, and notes
- Interactions:
  - DailyProgress belongs to a Student

```mermaid
classDiagram
class DailyProgress {
+integer Id
+date Date
+string Memorization_Progress_Surah
+integer Memorization_Progress_Ayah
+string Revision_Progress_Surah
+integer Revision_Progress_Ayah
+enum Memorization_Level
+enum Revision_Level
+text Notes
+integer StudentId
}
class Student {
+integer Id
}
DailyProgress --> Student : "records for"
```

**Diagram sources**
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)

**Section sources**
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)
- [models/index.js:53-55](file://backend/src/models/index.js#L53-L55)

### Monthly Rating System
- Purpose: Compute and store monthly ratings for memorization, recitation, Tajweed, Motoon, totals, averages
- Responsibilities:
  - Validate degree ranges per category
  - Calculate total and average scores
  - Associate ratings with a student
- Data Model: MonthlyRating entity with validated degree fields, totals, averages, and student reference
- Interactions:
  - MonthlyRating belongs to a Student

```mermaid
classDiagram
class MonthlyRating {
+integer Id
+float Memoisation_degree
+float Telawah_degree
+float Tajweed_degree
+float Motoon_degree
+float Total_degree
+float Average
+integer StudentId
}
class Student {
+integer Id
}
MonthlyRating --> Student : "rated for"
```

**Diagram sources**
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)

**Section sources**
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [models/index.js:45-47](file://backend/src/models/index.js#L45-L47)

### Graduate Tracking System
- Purpose: Track student graduation records and completion status
- Responsibilities:
  - Record graduation dates for completed students
  - Maintain one-to-one relationship with student records
  - Track completion status for academic progression
- Data Model: Graduate entity with graduation date and student reference
- Interactions:
  - Graduate belongs to a Student (one-to-one relationship)
  - Provides completion tracking for student lifecycle

```mermaid
classDiagram
class Graduate {
+integer Id
+date GraduationDate
+integer StudentId
}
class Student {
+integer Id
+string Name
+integer Age
+string current_Memorization
+string phoneNumber
+string ImageUrl
+string FatherNumber
+enum Category
+integer HalakatId
}
Graduate --> Student : "graduated from"
Student "1" --> "1" Graduate : "has record"
```

**Diagram sources**
- [Graduate.js:1-37](file://backend/src/models/Graduate.js#L1-L37)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)

**Section sources**
- [Graduate.js:1-37](file://backend/src/models/Graduate.js#L1-L37)
- [models/index.js:70-72](file://backend/src/models/index.js#L70-L72)

### Learning Plan Management
- Purpose: Manage learning plans associated with students
- Responsibilities:
  - Create, update, delete, and list learning plans
  - Link plans to individual students
- Data Model: StudentPlane entity (learning plan) with student reference
- Interactions:
  - StudentPlane belongs to a Student

```mermaid
classDiagram
class StudentPlane {
+integer Id
+integer StudentId
}
class Student {
+integer Id
}
StudentPlane --> Student : "plans for"
```

**Diagram sources**
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)
- [StudentPlane.js](file://backend/src/models/StudentPlane.js)

**Section sources**
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)
- [models/index.js:49-51](file://backend/src/models/index.js#L49-L51)

## Dependency Analysis
The system exhibits clear dependency relationships:
- Models depend on the database configuration
- The application depends on models for data access
- Routes depend on controllers for business logic
- Controllers depend on models for persistence
- Middleware depends on routes for request processing
- **New**: Area model depends on Center, User (supervisor), and User (mentor) models
- **New**: Area model creates cascading relationships with Halakat and Student models

```mermaid
graph LR
DB["Database Config"] --> MODELS["Models"]
MODELS --> CONTROLLERS["Controllers"]
CONTROLLERS --> ROUTES["Routes"]
ROUTES --> APP["Express App"]
APP --> CLIENT["Client Applications"]
CENTER["Center Model"] --> AREA["Area Model"]
USER["User Model"] --> AREA["Area Model"]
AREA["Area Model"] --> HALAKAT["Halakat Model"]
HALAKAT["Halakat Model"] --> STUDENT["Student Model"]
STUDENT["Student Model"] --> GRADUATE["Graduate Model"]
```

**Diagram sources**
- [database.js](file://backend/src/config/database.js)
- [models/index.js:1-91](file://backend/src/models/index.js#L1-L91)
- [server.js:1-26](file://backend/server.js#L1-L26)
- [AreaController.js:1-205](file://backend/src/controllers/AreaController.js#L1-L205)
- [Aria.js:1-59](file://backend/src/models/Aria.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Student.js:1-105](file://backend/src/models/Student.js#L1-L105)
- [Graduate.js:1-37](file://backend/src/models/Graduate.js#L1-L37)

**Section sources**
- [models/index.js:1-91](file://backend/src/models/index.js#L1-L91)
- [server.js:1-26](file://backend/server.js#L1-L26)

## Performance Considerations
- Database synchronization: The server synchronizes models on startup; consider production-safe alternatives to avoid data loss
- Validation: Model-level validations reduce invalid data but can increase write-time overhead; ensure appropriate indexing on foreign keys
- Associations: Use eager loading where necessary to prevent N+1 queries in list endpoints
- Caching: Introduce caching for frequently accessed master data (e.g., categories, levels)
- Pagination: Implement pagination for list endpoints to limit payload sizes
- **New**: Area-based queries should utilize proper indexing on CenterId, SupervisorId, and MentorId fields
- **New**: Area student counting queries should leverage JOIN operations for optimal performance
- **New**: Area search by name should use LIKE operations with proper indexing for large datasets

## Troubleshooting Guide
- Server startup failures:
  - Verify database connectivity and credentials
  - Confirm model registration and associations
- Authentication and authorization:
  - Implement middleware to validate tokens and enforce role-based access
- Data inconsistencies:
  - Use transactions for multi-step updates
  - Validate inputs at the controller level before delegating to models
- Logging:
  - Add structured logging for requests, errors, and audit trails
- **New**: Area management issues:
  - Ensure supervisor and mentor user validation before area assignment
  - Verify center association exists before creating areas
  - Check area name uniqueness constraints
  - Validate area location data for proper geographic representation
- **New**: Area student counting issues:
  - Ensure halakat-to-area relationships are properly established
  - Verify cascade operations maintain referential integrity
  - Check for orphaned student records in area queries

**Section sources**
- [server.js:1-26](file://backend/server.js#L1-L26)
- [auth.js](file://backend/src/middleware/auth.js)
- [AreaController.js:1-205](file://backend/src/controllers/AreaController.js#L1-L205)

## Conclusion
Khirocom's backend establishes a solid foundation for educational administration through well-defined models and associations. The MVC pattern is evident in the separation between models, controllers, routes, and middleware. The documented features—User Management, Center Administration, Area Management System, Teaching Group Management, Student Tracking, Daily Progress Monitoring, Monthly Rating System, Graduate Tracking System, and Learning Plan Management—are interconnected via foreign keys and associations. The addition of the Area Management System enhances the platform's ability to organize educational administration by geographic and administrative boundaries, providing supervisors and mentors with better oversight capabilities. To complete the system, ensure proper controller implementation for all area endpoints and integrate with frontend applications for comprehensive educational administration.

## Appendices

### Practical Usage Scenarios
- User Management
  - Create a teacher account and assign as center manager
  - List centers managed by a user
- Center Administration
  - Create a center and assign a manager
  - Retrieve all halakat under a center
- Area Management System
  - Create an area within a center and assign supervisor and mentor
  - List all areas supervised by a specific user
  - Count students enrolled in a particular area
  - Search areas by name containing specific keywords
- Teaching Group Management
  - Create a halakat and assign a teacher, center, and area
  - Enroll students into a halakat
- Student Tracking
  - Register a new student and enroll in a halakat
  - Update student profile and contact info
- Daily Progress Monitoring
  - Log daily memorization and revision progress for a student
  - Add notes for guidance
- Monthly Rating System
  - Submit monthly ratings for a student and compute totals/averages
- Graduate Tracking System
  - Record graduation date for completed student
  - Track completion status and generate graduation reports
- Learning Plan Management
  - Create a learning plan for a student and track progress

### Integration Patterns
- Frontend-backend communication:
  - RESTful endpoints for CRUD operations on each feature
  - JWT-based authentication middleware
  - Shared DTOs between frontend and backend for consistent payloads
- Modular development:
  - Keep routes, controllers, and middleware per feature module
  - Reuse shared middleware for cross-cutting concerns (auth, validation)
- Testing:
  - Unit tests for controllers and models
  - Integration tests for route flows and middleware behavior
- **New**: Area management integration:
  - Area endpoints support comprehensive CRUD operations with supervisor and mentor assignments
  - Area-based student counting provides real-time enrollment statistics
  - Area search functionality enables efficient geographic organization
  - Cascade operations maintain data integrity across center, area, halakat, and student relationships