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
      type: DataTypes.ENUM("ذكور", "إناث"),
      defaultValue: "ذكور",
      allowNull: false,
    },
    type: {
      type: DataTypes.ENUM("قراءة وكتاية", "حفظ ومراجعة", "إجازة", "قراءات"),
      defaultValue: "حفظ ومراجعة",
      allowNull: false,
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
    tableName: "halakat",
    modelName: "Halakat",
    timestamps: true,
    createdAt: 'createdDate',
    updatedAt: 'updatedDate',
  }
);

module.exports = Halakat;
