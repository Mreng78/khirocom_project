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
    defaultValue: "12345",
  },
  PhoneNumber: {
    type: DataTypes.STRING,
    allowNull: false,
  },

  AvatarUrl: {
    type: DataTypes.STRING,
    allowNull: true,
  },

  Role: {
      type: DataTypes.ENUM("admin", "مدرس", "مشرف", "موجه", "طالب", "مدير"),
    defaultValue: "مدرس",
    allowNull: false,
  },
  Gender: {
        type: DataTypes.ENUM("ذكر", "أنثى"),
        allowNull: false,
    },
    Age: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    EducationLevel: {
        type: DataTypes.STRING(256),
        allowNull: false,
    },
    Salary: {
        type: DataTypes.FLOAT,
        allowNull: false,
        defaultValue: 0,
    },
    Address: {
        type: DataTypes.STRING(256),
        allowNull: false,
    },
},
{
  sequelize,
  tableName: "users",
  modelName: "User",
  timestamps: true,
  hooks: {
    beforeCreate: (user) => {
      if (!user.Username) {
        user.Username = user.PhoneNumber;
      }
    },
  },
}
);

module.exports = User;

