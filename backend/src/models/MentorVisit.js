const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

class MentorVisit extends Model {}

MentorVisit.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  Month: {
    type: DataTypes.STRING,
    validate: { notEmpty: true },
    allowNull: false,
  },
  Year: {
    type: DataTypes.INTEGER,
    validate: { notEmpty: true },
    allowNull: false,
  },
  Recommendation: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  HalakatId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: "halakat",
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
}, {
  sequelize,
  modelName: "MentorVisit",
  tableName: "mentor_visits",
  timestamps: true,
  createdAt: 'createdDate',
  updatedAt: 'updatedDate',
});

module.exports = MentorVisit;
