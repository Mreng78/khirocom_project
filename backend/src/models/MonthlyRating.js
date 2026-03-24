const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class MonthlyRating extends Model {}

MonthlyRating.init(
  {
    Id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    Month:
    {
      type: DataTypes.STRING,
      validate: { notEmpty: true },
      allowNull: false,
    },
    Year:
    {
      type: DataTypes.INTEGER,
      validate: { notEmpty: true },
      allowNull: false,
    },
    Memoisation_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: { min: 0, max: 100 },
    },
    Telawah_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: { min: 0, max: 100 },
    },
    Tajweed_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: { min: 0, max: 60 },
    },
    Motoon_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: { min: 0, max: 400 },
    },
    Total_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    Average: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    Notes: {
      type: DataTypes.TEXT,
      allowNull: true,
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
    modelName: "MonthlyRating",
    tableName: "monthly_rating",
    timestamps: true,
  }
);

module.exports = MonthlyRating;