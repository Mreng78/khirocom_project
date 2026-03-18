const {Model,DataTypes} = require("sequelize")
const sequelize=require('../config/database')

class Graduate extends Model{}

Graduate.init({
    Id:{
        type:DataTypes.INTEGER,
        primaryKey:true,
        autoIncrement:true
    },
    GraduationDate:
    {
        type:DataTypes.DATE,
        allowNull:false
    },
    StudentId:
    {
        type:DataTypes.INTEGER,
        allowNull:false,
        references:
        {
            model:'students',
            key:'Id'
        }
    },
    
},
{
    sequelize,
    modelName:'Graduate',
    tableName:'Graduates'
}

);
module.exports=Graduate;
