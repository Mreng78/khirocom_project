const {Model,DataTypes} = require('sequelize');
const sequelize = require('../config/database');

class Teacher extends Model {}
Teacher.init({
    Id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
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
    User_Id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: "users",
            key: "Id",
        },
    },
}, { sequelize, modelName: 'Teacher', tableName: 'teachers' });

module.exports = Teacher;
