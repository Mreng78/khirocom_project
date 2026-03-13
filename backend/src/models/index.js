const sequelize = require("../config/database");

// استيراد جميع الموديلات
const User = require("./User");
const Center = require("./Center");
const Halakat = require("./Halakat");
const Student = require("./Student");
const StudentPlane = require("./StudentPlane");
const MonthlyRating = require("./MonthlyRating");
const DailyProgress = require("./DailyProgress");

// تعريف العلاقات بين الموديلات

// User ↔ Center (One-to-one)
User.hasOne(Center, { foreignKey: "ManagerId", as: "Center" });
Center.belongsTo(User, { foreignKey: "ManagerId", as: "Manager" });

// User ↔ Halakat (One-to-one)
User.hasOne(Halakat, { foreignKey: "TeacherId", as: "TeacherHalakat" });
Halakat.belongsTo(User, { foreignKey: "TeacherId", as: "Teacher" });

// Center ↔ Halakat (One-to-many)
Center.hasMany(Halakat, { foreignKey: "CenterId", as: "CenterHalakat" });
Halakat.belongsTo(Center, { foreignKey: "CenterId", as: "Center" });

// Halakat ↔ Student (One-to-Many)
Halakat.hasMany(Student, { foreignKey: "HalakatId", as: "HalakatStudents" });
Student.belongsTo(Halakat, { foreignKey: "HalakatId", as: "StudentHalakat" });

// Student ↔ MonthlyRating (One-to-Many)
Student.hasMany(MonthlyRating, { foreignKey: "StudentId", as: "Ratings" });
MonthlyRating.belongsTo(Student, { foreignKey: "StudentId", as: "RatingStudent" });

// Student ↔ StudentPlane (One-to-Many)
Student.hasMany(StudentPlane, { foreignKey: "StudentId", as: "Planes" });
StudentPlane.belongsTo(Student, { foreignKey: "StudentId", as: "PlaneStudent" });

// Student ↔ DailyProgress (One-to-Many)
Student.hasMany(DailyProgress, { foreignKey: "StudentId", as: "Progresses" });
DailyProgress.belongsTo(Student, { foreignKey: "StudentId", as: "ProgressStudent" });

module.exports = {
  sequelize,
  User,
  Center,
  Halakat,
  Student,
  StudentPlane,
  MonthlyRating,
  DailyProgress,
};
