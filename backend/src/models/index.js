const sequelize = require("../config/database");


const User = require("./User");
const Center = require("./Center");
const Halakat = require("./Halakat");
const Student = require("./Student");
const StudentPlane = require("./StudentPlane");
const MonthlyRating = require("./MonthlyRating");
const DailyProgress = require("./DailyProgress");
const Notification = require("./Notification");
const Aria = require("./Aria");



//? Area ↔ Center (One-to-many)
Center.hasMany(Aria, { foreignKey: "CenterId", as: "CenterArias" });
Aria.belongsTo(Center, { foreignKey: "CenterId", as: "Center" });


//? User ↔ Center (One-to-one)
User.hasOne(Center, { foreignKey: "ManagerId", as: "center" });
Center.belongsTo(User, { foreignKey: "ManagerId", as: "manager" });

//? User ↔ Halakat (One-to-one)
User.hasOne(Halakat, { foreignKey: "TeacherId", as: "TeacherHalakat" });
Halakat.belongsTo(User, { foreignKey: "TeacherId", as: "Teacher" });

//? Aria ↔ Halakat (One-to-many)
Aria.hasMany(Halakat, { foreignKey: "AriaId", as: "AriaHalakat" });
Halakat.belongsTo(Aria, { foreignKey: "AriaId", as: "Aria" });

//? Area ↔  User <supervisor> (many-to-many)
Aria.belongsToMany(User, { through: "SupervisorArias", foreignKey: "AriaId" });
User.belongsToMany(Aria, { through: "SupervisorArias", foreignKey: "UserId" });


//? User ↔  Area <mentor> (many-to-many)
User.belongsToMany(Aria, { through: "MentorArias", foreignKey: "UserId" });
Aria.belongsToMany(User, { through: "MentorArias", foreignKey: "AriaId" });

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
  Aria,
};
