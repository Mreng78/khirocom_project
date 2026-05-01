const { Model, DataTypes } = require("sequelize");
const sequelize = require('../config/database');

class Graduate extends Model {}

Graduate.init({
    Id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    GraduationDate: {
        type: DataTypes.DATE,
        allowNull: false
    },
    StudentId: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
            model: 'students',
            key: 'Id'
        }
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
}, {
    sequelize,
    modelName: 'Graduate',
    tableName: 'Graduates',
    timestamps: true,
    createdAt: 'createdDate',
    updatedAt: 'updatedDate',
});

module.exports = Graduate;
