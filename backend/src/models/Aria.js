const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class Aria extends Model {}
Aria.init(
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
    modelName: "Aria",
    tableName: "arias",
    timestamps: false,
  }
);

module.exports = Aria;
