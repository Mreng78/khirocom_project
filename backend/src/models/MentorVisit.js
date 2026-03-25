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
  HalaqahId:
  {
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
},
{
    sequelize,
    modelName: "MentorVisit",
    tableName: "mentor_visits",
});


module.exports = MentorVisit;
