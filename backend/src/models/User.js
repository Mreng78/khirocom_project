const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class User extends Model {}

User.init(
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

  Username: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  Password: {
    type: DataTypes.STRING(255),
    allowNull: false,
  },

  Email: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  PhoneNumber: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  Avatar: {
    type: DataTypes.STRING,
    allowNull: true,
  },

  Role: {
    type: DataTypes.ENUM("admin", "teacher", "supervisor", "manager"),
    defaultValue: "teacher",
    allowNull: false,
  },

},
{
  sequelize,
  tableName: "users",
  modelName: "User",
  timestamps: true
}
);

module.exports = User;