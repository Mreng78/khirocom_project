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
        "child",
        "5_parts",
        "10_parts",
        "15_parts",
        "20_parts",
        "25_parts",
        "30_parts"
      ),
      defaultValue: "child",
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