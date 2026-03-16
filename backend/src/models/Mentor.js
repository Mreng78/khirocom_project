const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/database");


class Mentor extends Model {}
Mentor.init({
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
},{sequelize, modelName:'Mentor', tableName:'mentors'});

module.exports=Mentor;
