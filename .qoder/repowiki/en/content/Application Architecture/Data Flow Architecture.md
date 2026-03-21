# Data Flow Architecture

<cite>
**Referenced Files in This Document**
- [server.js](file://backend/server.js)
- [app.js](file://backend/src/config/app.js)
- [database.js](file://backend/src/config/database.js)
- [models/index.js](file://backend/src/models/index.js)
- [User.js](file://backend/src/models/User.js)
- [Student.js](file://backend/src/models/Student.js)
- [DailyProgress.js](file://backend/src/models/DailyProgress.js)
- [MonthlyRating.js](file://backend/src/models/MonthlyRating.js)
- [Center.js](file://backend/src/models/Center.js)
- [Halakat.js](file://backend/src/models/Halakat.js)
- [StudentPlane.js](file://backend/src/models/StudentPlane.js)
- [package.json](file://backend/package.json)
</cite>

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

## Introduction
This document explains the data flow architecture of the Khirocom application. It covers the end-to-end request-response lifecycle from incoming HTTP requests through Express routes and controllers to Sequelize ORM-backed model operations. It also documents asynchronous patterns using Promises, error propagation across layers, and practical performance considerations for optimizing data flow and caching strategies.

## Project Structure
The backend follows a layered architecture:
- Entry point initializes the Express app and connects to the database via Sequelize.
- Models define the domain entities and associations.
- Routes define endpoints and delegate to controllers.
- Controllers orchestrate business logic and interact with models.
- Middleware handles cross-cutting concerns (e.g., JSON parsing).
- Configuration files set up the Express app and database connection.

```mermaid
graph TB
subgraph "Entry Point"
S["server.js"]
end
subgraph "Express App"
A["src/config/app.js"]
end
subgraph "Database Layer"
D["src/config/database.js"]
MIdx["src/models/index.js"]
U["User.js"]
C["Center.js"]
H["Halakat.js"]
St["Student.js"]
SP["StudentPlane.js"]
MR["MonthlyRating.js"]
DP["DailyProgress.js"]
end
S --> A
S --> D
A --> MIdx
MIdx --> U
MIdx --> C
MIdx --> H
MIdx --> St
MIdx --> SP
MIdx --> MR
MIdx --> DP
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Student.js:1-67](file://backend/src/models/Student.js#L1-L67)
- [StudentPlane.js:1-76](file://backend/src/models/StudentPlane.js#L1-L76)
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)

**Section sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)

## Core Components
- Server bootstrap: Initializes environment, authenticates to the database, synchronizes models, and starts the HTTP server.
- Express app: Registers middleware and basic route.
- Database configuration: Creates a Sequelize instance with MySQL dialect.
- Models and associations: Define entities and relationships; exported for use across the application.
- Dependencies: Express, Sequelize, MySQL2, and supporting libraries.

Key responsibilities:
- server.js orchestrates startup and error handling.
- app.js defines the Express app and JSON body parsing.
- database.js encapsulates database credentials and connection options.
- models/index.js centralizes model imports and associations.
- package.json lists runtime dependencies.

**Section sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [package.json:1-14](file://backend/package.json#L1-L14)

## Architecture Overview
The application uses a classic layered architecture:
- Presentation: Express routes and controllers.
- Domain: Sequelize models representing entities and associations.
- Persistence: MySQL via Sequelize ORM.

```mermaid
graph TB
Client["Client"] --> Express["Express App"]
Express --> Routes["Routes (not shown)"]
Routes --> Controller["Controllers (not shown)"]
Controller --> Models["Sequelize Models"]
Models --> DB["MySQL Database"]
subgraph "Startup"
S["server.js"]
A["src/config/app.js"]
D["src/config/database.js"]
MIdx["src/models/index.js"]
end
S --> A
S --> D
A --> MIdx
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)

## Detailed Component Analysis

### Database Layer: Models and Associations
The models define the domain schema and relationships. Associations establish foreign keys and named associations for navigation.

```mermaid
erDiagram
USER {
int Id PK
string Name
string Username
string Password
string Email
string PhoneNumber
string Avatar
enum Role
datetime createdAt
datetime updatedAt
}
CENTER {
int Id PK
string Name
string Location
int ManagerId FK
datetime createdAt
datetime updatedAt
}
HALAKAT {
int Id PK
string Name
int studentsCount
int TeacherId FK
int CenterId FK
datetime createdAt
datetime updatedAt
}
STUDENT {
int Id PK
string Name
int Age
string current_Memorization
string phoneNumber
string imageUrl
string FatherNumber
enum Category
int HalakatId FK
datetime createdAt
datetime updatedAt
}
STUDENT_PLANE {
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
MONTHLY_RATING {
int Id PK
float Memoisation_degree
float Telawah_degree
float Tajweed_degree
float Motoon_degree
float Total_degree
float Avarage
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
USER ||--o{ CENTER : "Manages (ManagerId)"
USER ||--o{ HALAKAT : "Teachers (TeacherId)"
CENTER ||--o{ HALAKAT : "Hosts (CenterId)"
HALAKAT ||--o{ STUDENT : "Enrolls (HalakatId)"
STUDENT ||--o{ STUDENT_PLANE : "Has plans (StudentId)"
STUDENT ||--o{ MONTHLY_RATING : "Rated (StudentId)"
STUDENT ||--o{ DAILY_PROGRESS : "Tracked (StudentId)"
```

**Diagram sources**
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Student.js:1-67](file://backend/src/models/Student.js#L1-L67)
- [StudentPlane.js:1-76](file://backend/src/models/StudentPlane.js#L1-L76)
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)

**Section sources**
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)
- [Center.js:1-39](file://backend/src/models/Center.js#L1-L39)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)
- [Student.js:1-67](file://backend/src/models/Student.js#L1-L67)
- [StudentPlane.js:1-76](file://backend/src/models/StudentPlane.js#L1-L76)
- [MonthlyRating.js:1-70](file://backend/src/models/MonthlyRating.js#L1-L70)
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)

### Request-Response Lifecycle
The lifecycle begins at the server bootstrap and proceeds through Express initialization and model synchronization.

```mermaid
sequenceDiagram
participant Client as "Client"
participant Server as "server.js"
participant App as "src/config/app.js"
participant DB as "src/config/database.js"
participant Models as "src/models/index.js"
Client->>Server : "Start application"
Server->>DB : "Authenticate"
DB-->>Server : "Connection OK"
Server->>Models : "Load models and associations"
Models-->>Server : "Model registry ready"
Server->>App : "Listen on port"
App-->>Client : "HTTP server running"
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)

**Section sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [database.js:1-15](file://backend/src/config/database.js#L1-L15)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)

### Asynchronous Operations and Promise-Based Patterns
- Server startup uses async/await for database authentication and model synchronization.
- Express app initialization is synchronous after startup.
- Sequelize operations return Promises; application logic should handle them with async/await or .then/.catch.

Operational pattern:
- Startup: authenticate → sync models → listen.
- Route handling: parse request → controller logic → model queries → respond.

**Section sources**
- [server.js:8-23](file://backend/server.js#L8-L23)
- [app.js:5](file://backend/src/config/app.js#L5)

### Error Propagation Through Layers
- Server layer: Centralized try/catch around startup; logs failures and prevents crash.
- Database layer: Sequelize authentication and sync propagate errors upward.
- Model layer: Validation and constraint violations surface as Sequelize errors.
- Controller layer: Should wrap async operations in try/catch and forward errors to Express error-handling middleware.
- Express layer: Standard error middleware should normalize errors and send appropriate HTTP responses.

Recommended practice:
- Use centralized error handling middleware to avoid unhandled promise rejections.
- Log errors with context (request ID, endpoint, user) for diagnostics.

[No sources needed since this section provides general guidance]

### Typical Data Flow Scenarios

#### Scenario 1: User Authentication
This scenario illustrates a typical login flow using the User model.

```mermaid
sequenceDiagram
participant Client as "Client"
participant Server as "server.js"
participant App as "src/config/app.js"
participant Models as "src/models/index.js"
participant UserM as "User.js"
Client->>Server : "POST /login"
Server->>App : "Route dispatch"
App->>UserM : "Find user by credentials"
UserM-->>App : "User record or null"
App-->>Client : "Token or error"
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [User.js:1-59](file://backend/src/models/User.js#L1-L59)

#### Scenario 2: Student Enrollment
This scenario enrolls a student into a halakah via the Student and Halakat models.

```mermaid
sequenceDiagram
participant Client as "Client"
participant Server as "server.js"
participant App as "src/config/app.js"
participant Models as "src/models/index.js"
participant StM as "Student.js"
participant HM as "Halakat.js"
Client->>Server : "POST /enroll"
Server->>App : "Route dispatch"
App->>HM : "Fetch halakah"
HM-->>App : "Halakat exists"
App->>StM : "Create student with HalakatId"
StM-->>App : "Created student"
App-->>Client : "Enrollment confirmed"
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [Student.js:1-67](file://backend/src/models/Student.js#L1-L67)
- [Halakat.js:1-47](file://backend/src/models/Halakat.js#L1-L47)

#### Scenario 3: Progress Tracking
This scenario records daily progress for a student using the DailyProgress model.

```mermaid
sequenceDiagram
participant Client as "Client"
participant Server as "server.js"
participant App as "src/config/app.js"
participant Models as "src/models/index.js"
participant DP as "DailyProgress.js"
participant StM as "Student.js"
Client->>Server : "POST /progress"
Server->>App : "Route dispatch"
App->>StM : "Verify student exists"
StM-->>App : "Student found"
App->>DP : "Create daily progress"
DP-->>App : "Progress saved"
App-->>Client : "Success response"
```

**Diagram sources**
- [server.js:1-25](file://backend/server.js#L1-L25)
- [app.js:1-12](file://backend/src/config/app.js#L1-L12)
- [models/index.js:1-52](file://backend/src/models/index.js#L1-L52)
- [DailyProgress.js:1-64](file://backend/src/models/DailyProgress.js#L1-L64)
- [Student.js:1-67](file://backend/src/models/Student.js#L1-L67)

## Dependency Analysis
Runtime dependencies include Express, Sequelize, MySQL2, and supporting libraries. These enable HTTP handling, ORM capabilities, and database connectivity.

```mermaid
graph TB
P["package.json"]
E["express"]
SQ["sequelize"]
M2["mysql2"]
DJ["dotenv"]
JWT["jsonwebtoken"]
BC["bcrypt/bcryptjs"]
AX["axios"]
P --> E
P --> SQ
P --> M2
P --> DJ
P --> JWT
P --> BC
P --> AX
```

**Diagram sources**
- [package.json:1-14](file://backend/package.json#L1-L14)

**Section sources**
- [package.json:1-14](file://backend/package.json#L1-L14)

## Performance Considerations
- Asynchronous startup: Database authentication and model synchronization occur during boot; ensure adequate timeouts and health checks.
- Sequelize operations: Use eager loading (includes) judiciously to avoid N+1 queries; leverage associations defined in models.
- Pagination: For list endpoints, implement pagination to limit payload sizes.
- Caching: Cache infrequent reads (e.g., master data) using an in-memory cache or Redis; invalidate on write operations.
- Indexing: Ensure foreign keys and frequently queried columns are indexed in MySQL.
- Connection pooling: Configure Sequelize pool settings appropriately for expected concurrency.
- Logging: Keep SQL logging disabled in production to reduce overhead.

[No sources needed since this section provides general guidance]

## Troubleshooting Guide
Common issues and resolutions:
- Database connection failures: Verify environment variables and network access; confirm authentication in server startup logs.
- Model synchronization errors: Review association definitions and foreign key constraints; ensure migrations are applied.
- Unhandled promise rejections: Add centralized error-handling middleware in Express to catch and log errors consistently.
- Validation errors: Sequelize validations (e.g., enums, ranges) will throw errors; surface user-friendly messages while logging details.

**Section sources**
- [server.js:9-22](file://backend/server.js#L9-L22)
- [MonthlyRating.js:18-28](file://backend/src/models/MonthlyRating.js#L18-L28)

## Conclusion
Khirocom’s data flow architecture centers on an Express server, Sequelize ORM, and a well-defined set of models with explicit associations. The application uses asynchronous patterns throughout, with startup and model synchronization occurring at boot. By adopting centralized error handling, careful use of associations and includes, and pragmatic caching strategies, the system can maintain responsiveness and reliability as it evolves.