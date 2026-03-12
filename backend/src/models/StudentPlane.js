const {Model,DataTypes}=require("sequelize")
const sequelize= require('../config/database')
const Student=require('./Student')
class StudentPlane extends Model{}

StudentPlane.init(
    {
        Id:{
            type:DataTypes.INTEGER,
            primaryKey:true,
            autoIncrement:true
        },
        Current_Memorization_Surah:
        {
            type:DataTypes.STRING,
            allowNull:false
        },
        Current_Memorization_Ayah:
        {
            type:DataTypes.INTEGER,
            allowNull:false
        },
        Daily_Memorization_Amount:
        {
            type:DataTypes.DECIMAL(10,2),
            allowNull:false
        },
        target_Memorization_Surah:
        {
            type:DataTypes.STRING,
            allowNull:false
        },
        target_Memorization_Ayah:
        {
            type:DataTypes.INTEGER,
            allowNull:false
        },
        Daily_Revision_Amount:
        {
            type:DataTypes.DECIMAL(10,2),
            allowNull:false
        },
        Current_Revision:
        {
            type:DataTypes.STRING,
            allowNull:false
        },
        target_Revision:
        {
            type:DataTypes.STRING,
            allowNull:false
        },
        StartsAt:
        {
            type:DataTypes.DATE,
            allowNull:false
        },
        EndsAt:
        {
            type:DataTypes.DATE,
            allowNull:false
        },
        ItsDone:
        {
            type:DataTypes.BOOLEAN, 
            defaultValue:false,
            allowNull:false
        }    
    },
    {
  sequelize,
  tableName: "StudentPlane",
  modelName: "StudentPlane",
  timestamps: true
}
);

StudentPlane.belongsTo(Student,{foreignkay:'StudentId',as:'Student'});

module.exports=StudentPlane;
