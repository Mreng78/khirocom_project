const {Model,DataTypes} = require('sequelize');
const sequelize = require("../config/database");


class Notification extends Model{}

Notification.init({
    Id:
    {
        type:DataTypes.INTEGER,
        primaryKey:true,
        autoIncrement:true
    },
    Title:
    {
        type:DataTypes.STRING,
        allowNull:false
    },
    Description:
    {
        type:DataTypes.STRING,
        allowNull:false
    },
    Date:
    {
        type:DataTypes.DATE,
        allowNull:false
    },
    Time:
    {
        type:DataTypes.TIME,
        allowNull:false
    },
    Type:
    {
        type:DataTypes.ENUM,
        values:['Personal','General'],
        allowNull:false
    },
    IsRead:
    {
        type:DataTypes.BOOLEAN,
        allowNull:false,
        defaultValue:false
    },
    ReadAt:
    {
        type:DataTypes.DATE,
        allowNull:true
    },
    UserId:
    {
        type:DataTypes.INTEGER,
        allowNull:true,
        references:
        {
            model:'users',
            key:'Id'
        }
    },
    StudentId:
    {
        type:DataTypes.INTEGER,
        allowNull:true,
        references:
        {
            model:'students',
            key:'Id'
        }
    }
},
{
    sequelize,
    tableName:'Notifications',
    modelName:'Notification',
    timestamps:true
});

module.exports = Notification;
