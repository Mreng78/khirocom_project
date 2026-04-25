const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class StudentPlane extends Model {}

StudentPlane.init(
  {
    Id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    Current_Memorization_Surah: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Current_Memorization_Ayah: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    Daily_Memorization_Amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    target_Memorization_Surah: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    target_Memorization_Ayah: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    Daily_Revision_Amount: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    Current_Revision: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    target_Revision: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    StartsAt: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    EndsAt: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    Month: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Year: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Is_Current_Month_Plan: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    Memorization_ItsDone: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    Revision_ItsDone: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    StudentId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "students",
        key: "Id",
      },
    },
  },
  {
    sequelize,
    tableName: "student_planes",
    modelName: "StudentPlane",
    timestamps: true,
  }
);

module.exports = StudentPlane;
