const {Model,DataTypes}=require('sequelize');
const sequelize=require('../config/database');


class Supervisor extends Model {}
Supervisor.init({
    Id:{
        type:DataTypes.INTEGER,
        primaryKey:true,
        autoIncrement:true
    },
    Gender:{
        type:DataTypes.ENUM("ذكر","أنثى"),
        defaultValue:"ذكر",
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
},{sequelize, modelName:'Supervisor', tableName:'supervisors'});

module.exports=Supervisor;
