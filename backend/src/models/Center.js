const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class Center extends Model {}

Center.init(
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
    Location: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ManagerId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "users",
        key: "Id",
      },
    },
  },
  {
    sequelize,
    tableName: "centers",
    modelName: "Center",
    timestamps: true,
  }
);

module.exports = Center;

