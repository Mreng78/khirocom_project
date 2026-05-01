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
    SupervisorId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "users",
        key: "Id",
      },
    },
    MentorId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "users",
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
    modelName: "Aria",
    tableName: "arias",
    timestamps: true,
    createdAt: 'createdDate',
    updatedAt: 'updatedDate',
  }
);

module.exports = Aria;
