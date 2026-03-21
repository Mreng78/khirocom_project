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
    studentsGender: {
      type: DataTypes.ENUM("ذكور","إناث"),
      defaultValue:"ذكور",
      allowNull: false,
    },
    type:
    {
      type:DataTypes.ENUM("قراءة وكتاية","حفظ ومراجعة","إجازة","قراءات"),
      defaultValue:"حفظ ومراجعة",
      allowNull:false
    },
    TeacherId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "users",
        key: "Id",
      },
    },
    AriaId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: "arias",
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
