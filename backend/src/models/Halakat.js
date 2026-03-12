const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const User = require("./User");
const Center = require("./Center");
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
  },
  {
    sequelize,
    tableName: "halakat",
    modelName: "Halakat",
    timestamps: true,
  },
);
Halakat.belongsTo(User, { foreignkay: "TeacherId", as: "Teacher" });
Halakat.belongsTo(Center, { foreignkay: "CenterId", as: "Center" });

module.exports = Halakat;
