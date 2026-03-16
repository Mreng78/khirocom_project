const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");
class Manager extends Model {}
Manager.init({
    Id:{
        type:DataTypes.INTEGER,
        primaryKey:true,
        autoIncrement:true
    },
    Gender:{
        type:DataTypes.ENUM("ذكر","أنثى"),
        allowNull:false
    },
    Age:{
        type:DataTypes.INTEGER,
        allowNull:false
    },
    EducationLevel:{
        type:DataTypes.STRING,
        allowNull:false
    },
    User_Id:{
        type:DataTypes.INTEGER,
        allowNull:false,
        references:{
            model:"users",
            key:"Id"
        }
    }
},{sequelize, modelName:'Manager', tableName:'managers'});

module.exports=Manager;
