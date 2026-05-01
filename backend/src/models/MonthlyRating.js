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
    MentorVisetId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "mentor_visits",
        key: "Id",
      },
    },
    isSynced: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    isDeleted: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    createdDate: {
      type: DataTypes.DATE,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP'),
      allowNull: true,
    },
    updatedDate: {
      type: DataTypes.DATE,
      defaultValue: sequelize.literal('CURRENT_TIMESTAMP'),
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: "MonthlyRating",
    tableName: "monthly_rating",
    timestamps: true,
    createdAt: 'createdDate',
    updatedAt: 'updatedDate',
  }
);

module.exports = MonthlyRating;