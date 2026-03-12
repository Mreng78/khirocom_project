const {Model,DataTypes}=require("sequelize")
const sequelize= require('../config/database')
const Student=require('./Student')  

class DailyProgress extends Model{}

DailyProgress.init(
    {
        Id:{
            type:DataTypes.INTEGER,
            primaryKey:true,
            autoIncrement:true
        },
        Date:{
            type:DataTypes.DATE,
            allowNull:false
        },
        Memorization_Progress_Surah:{
            type:DataTypes.STRING,
            allowNull:false
        },
        Memorization_Progress_Ayah:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        Revision_Progress_Surah:{
            type:DataTypes.STRING,
            allowNull:false
        },
        Revision_Progress_Ayah:{
            type:DataTypes.INTEGER,
            allowNull:false
        },
        Memorization_Level:{
            type:dataTypes.ENUM("ضعيق","مقيول","جيد","جيد جدا","ممتاز"),
            defaultValue:"ضعيق",
            allowNull:false
        },
        Revision_Level:{
            type:dataTypes.ENUM("ضعيق","مقيول","جيد","جيد جدا","ممتاز"),
            defaultValue:"ضعيق",
            allowNull:false
        },
        Notes:{
            type:DataTypes.TEXT,
            allowNull:true
        }

    },
    {
  sequelize,
  tableName: "DailyProgress",
  modelName: "DailyProgress",
  timestamps: true
}
);

DailyProgress.belongsTo(Student,{foreignkay:'StudentId',as:'Student'});

module.exports=DailyProgress;