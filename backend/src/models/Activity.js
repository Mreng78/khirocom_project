const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const Halakat = require("./Halakat");

class Activity extends Model {}
Activity.init(
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
    Date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    Place: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    Description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    Kind: {
      type: DataTypes.ENUM("رياضي", "ثقافي", "مسابقة قرآنية", "ترفيهي", "أخرى"),
      defaultValue: "مسابقة قرآنية",
      allowNull: false,
    },
    HalaqahId:
    {
        type:DataTypes.INTEGER,
        allowNull:false,
        references:
        {
            model:'halakat',
            key:'Id'
        }
    }
  },
  {
    sequelize,
    modelName: "Activity",
    tableName: "Activities",
  },
);
module.exports = Activity;
