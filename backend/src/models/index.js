const sequelize = require("../config/database");


const User = require("./User");
const Center = require("./Center");
const Halakat = require("./Halakat");
const Student = require("./Student");
const StudentPlane = require("./StudentPlane");
const MonthlyRating = require("./MonthlyRating");
const DailyProgress = require("./DailyProgress");
const Notification = require("./Notification");
const Teacher = require("./Teacher");
const Supervisor = require("./Supervisor");
const Mentor = require("./Mentor");
const Manager = require("./Manager");




//? User ↔ Center (One-to-one)
User.hasOne(Center, { foreignKey: "ManagerId", as: "center" });
Center.belongsTo(User, { foreignKey: "ManagerId", as: "manager" });

//? User ↔ Halakat (One-to-one)
User.hasOne(Halakat, { foreignKey: "TeacherId", as: "TeacherHalakat" });
Halakat.belongsTo(User, { foreignKey: "TeacherId", as: "Teacher" });

//? Center ↔ Halakat (One-to-many)
Center.hasMany(Halakat, { foreignKey: "CenterId", as: "CenterHalakat" });
Halakat.belongsTo(Center, { foreignKey: "CenterId", as: "Center" });

//? Halakat ↔ Student (One-to-Many)
Halakat.hasMany(Student, { foreignKey: "HalakatId", as: "HalakatStudents" });
Student.belongsTo(Halakat, { foreignKey: "HalakatId", as: "StudentHalakat" });

//? Student ↔ MonthlyRating (One-to-Many)
Student.hasMany(MonthlyRating, { foreignKey: "StudentId", as: "Ratings" });
MonthlyRating.belongsTo(Student, { foreignKey: "StudentId", as: "RatingStudent" });

//? Student ↔ StudentPlane (One-to-Many)
Student.hasMany(StudentPlane, { foreignKey: "StudentId", as: "Planes" });
StudentPlane.belongsTo(Student, { foreignKey: "StudentId", as: "PlaneStudent" });

//? Student ↔ DailyProgress (One-to-Many)
Student.hasMany(DailyProgress, { foreignKey: "StudentId", as: "Progresses" });
DailyProgress.belongsTo(Student, { foreignKey: "StudentId", as: "ProgressStudent" });

//? User ↔ Notification (One-to-Many)
User.hasMany(Notification, { foreignKey: "UserId", as: "UserNotifications" });
Notification.belongsTo(User, { foreignKey: "UserId", as: "NotificationUser" });


//? Student ↔ Notification (One-to-Many)
Student.hasMany(Notification, { foreignKey: "StudentId", as: "StudentNotifications" });
Notification.belongsTo(Student, { foreignKey: "StudentId", as: "NotificationStudent" });

//? Student ↔ Users (One-to-Many)
User.hasMany(Student, { foreignKey: "User_Id", as: "Students" });
Student.belongsTo(User, { foreignKey: "User_Id", as: "User" });

//? teacher ↔ User (One-to-Many)
User.hasMany(Teacher, { foreignKey: "User_Id", as: "Teacher" });
Teacher.belongsTo(User, { foreignKey: "User_Id", as: "Teacher" });

//? Supervisor ↔ User (one to many)
User.hasMany(Supervisor, { foreignKey: "User_Id", as: "Supervisors" });
Supervisor.belongsTo(User, { foreignKey: "User_Id", as: "User" });

//? Mentor ↔ User (one to many)
User.hasMany(Mentor, { foreignKey: "User_Id", as: "Mentors" });
Mentor.belongsTo(User, { foreignKey: "User_Id", as: "User" });
//? Manager ↔ User (one to many)
User.hasMany(Manager, { foreignKey: "User_Id", as: "Managers" });
Manager.belongsTo(User, { foreignKey: "User_Id", as: "User" });

//? Halakat ↔ Supervisor (One-to-Many)
Supervisor.hasMany(Halakat, { foreignKey: "SupervisorId", as: "Halakat" });
Halakat.belongsTo(Supervisor, { foreignKey: "SupervisorId", as: "Supervisor" });


//? Halakat ↔ Mentor (One-to-Many)
Mentor.hasMany(Halakat, { foreignKey: "MentorId", as: "Halakat" });
Halakat.belongsTo(Mentor, { foreignKey: "MentorId", as: "Mentor" });



module.exports = {
  sequelize,
  User,
  Center,
  Halakat,
  Student,
  StudentPlane,
  MonthlyRating,
  DailyProgress,
  Notification,
  Teacher,
  Supervisor,
  Mentor,
  Manager,
};
