const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const User = require("./User");

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
  },
  {
    sequelize,
    tableName: "centers",
    modelName: "Center",
    timestamps: true,
  },
);

Center.belongsTo(User, {
  foreignKey: "ManagerId",
  as: "Manager",
});

module.exports = Center;
