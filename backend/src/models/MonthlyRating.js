const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Student = require("./Student");

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
      validate: {
        min: 0,
        max: 100,
      },
    },
    Telawah_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: {
        min: 0,
        max: 100,
      },
    },
    Tajweed_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: {
        min: 0,
        max: 60,
      },
    },
    Motoon_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
      validate: {
        min: 0,
        max: 400,
      },
    },
    Total_degree: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    Avarage: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    StudentId: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    sequelize,
    modelName: "MonthlyRating",
    tableName: "MonthlyRating",
    timestamps: true,
  }
);

MonthlyRating.belongsTo(Student, { foreignKey: "StudentId", as: "Student" });

module.exports = MonthlyRating;