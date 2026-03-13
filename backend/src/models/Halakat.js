const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class Halakat extends Model {}

Halakat.init(
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
    studentsCount: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    TeacherId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "users",
        key: "Id",
      },
    },
    CenterId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "centers",
        key: "Id",
      },
    },
  },
  {
    sequelize,
    tableName: "halakat",
    modelName: "Halakat",
    timestamps: true,
  }
);

module.exports = Halakat;
