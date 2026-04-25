const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class DailyProgress extends Model {}

DailyProgress.init(
  {
    Id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    Attendance: {
      type: DataTypes.ENUM("مستأذن", "غائب", "حاضر"),
      allowNull: false,
    },
    Memorization_Progress_Surah: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Memorization_Progress_Ayah: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    Revision_Progress_Surah: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Revision_Progress_Ayah: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    Memorization_Level: {
      type: DataTypes.ENUM("ضعيف", "مقبول", "جيد", "جيد جدا", "ممتاز","-"),
      defaultValue: "-",
      allowNull: false,
    },
    Revision_Level: {
      type: DataTypes.ENUM("ضعيف", "مقبول", "جيد", "جيد جدا", "ممتاز","-"),
      defaultValue: "-",
      allowNull: false,
    },
    Notes: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    month: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    DayName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Date: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    year: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    Month_year:{
      type: DataTypes.STRING,
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
    tableName: "daily_progress",
    modelName: "DailyProgress",
    timestamps: true,
  }
);

module.exports = DailyProgress;