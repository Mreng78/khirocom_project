const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const DailyProgress = require("./DailyProgress");
class Student extends Model {}

Student.init(
  {
    Id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    Name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Gender: {
      type: DataTypes.ENUM("ذكر", "أنثى"),
      defaultValue: "ذكر",
      allowNull: false,
    },
    Username: {
      type: DataTypes.STRING,
      allowNull: true,
      
    },
    Password: {
      type: DataTypes.STRING(256),
      defaultValue: "12345",
      allowNull: false,
    },
    status:
    {
      type:DataTypes.ENUM("مستمر","منقطع","مفصول"),
      defaultValue:"مستمر",
      allowNull:false
    },
    stopDate: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW(),
      allowNull: true,
    },
    stopReason: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    DismissedDate: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW(),
      allowNull: true,
    },
    DismissedReason: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Age: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    current_Memorization_Sorah: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    current_Revision_Sorah:
    {
      type:DataTypes.STRING,
      allowNull:true
    },
    current_Revision_Aya:
    {
      type:DataTypes.INTEGER,
      allowNull:true
    },
    current_Memorization_Aya: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ImageUrl: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    FatherNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Category: {
      type: DataTypes.ENUM(
        "اطفال",
        "أقل من 5 أجزاء",
        "5 أجزاء",
        "10 أجزاء",
        "15 جزء",
        "20 جزء",
        "25 جزء",
        "المصحف كامل",
        "إجازة"
      ),
      defaultValue: "أقل من 5 أجزاء",
      allowNull: false,
    },
    HalakatId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "halakat",
        key: "Id",
      },
    },
  },
  {
    sequelize,
    tableName: "students",
    modelName: "Student",
    timestamps: true,
    hooks: {
      beforeCreate: (student) => {
        if (!student.Username) {
          student.Username = student.phoneNumber;
        }
      },
    },
  },
);

module.exports = Student;