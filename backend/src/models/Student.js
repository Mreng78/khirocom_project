const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

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
      allowNull: false,
    },
    Username: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Password: {
      type: DataTypes.STRING(256),
      allowNull: false,
    },
    Age: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    current_Memorization: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    imageUrl: {
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
        "المصجف كامل"
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
  }
);

module.exports = Student;