const { Model, DataTypes } = require('sequelize');
const sequelize = require("../config/database");

class Notification extends Model {}

Notification.init({
    Id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    Title: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Description: {
        type: DataTypes.STRING,
        allowNull: false
    },
    Date: {
        type: DataTypes.DATE,
        allowNull: false
    },
    Time: {
        type: DataTypes.TIME,
        allowNull: false
    },
    Type: {
        type: DataTypes.ENUM,
        values: ['general', 'personal'],
        allowNull: false
    },
    forWho: {
        type: DataTypes.ENUM,
        values: ['students', 'Teachers', 'supervisors', 'mentors'],
        allowNull: false
    },
    IsRead: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false
    },
    ReadAt: {
        type: DataTypes.DATE,
        allowNull: true
    },
    UserId: {
        type: DataTypes.INTEGER,
        allowNull: true,
        references: {
            model: 'users',
            key: 'Id'
        }
    },
    StudentId: {
        type: DataTypes.INTEGER,
        allowNull: true,
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
    tableName: 'Notifications',
    modelName: 'Notification',
    timestamps: true,
    createdAt: 'createdDate',
    updatedAt: 'updatedDate',
});

module.exports = Notification;
