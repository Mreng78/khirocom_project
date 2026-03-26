const { Notification, Student, User } = require("../models");
const {Op}=require("sequelize");

exports.createNotification = async (req, res) => {
    try {
        const { forWho, Type } = req.body;

        if (!forWho) {
            return res.status(400).json({ message: "forWho is required" });
        }
        if (!Type) {
            return res.status(400).json({ message: "Type is required" });
        }

        // Personal notification - single recipient
        if (Type === 'personal') {
            const notification = await Notification.create(req.body);
            return res.status(201).json({
                message: "Notification created successfully",
                notification
            });
        }

        // General notification to all students
        if (Type === 'general' && forWho === 'students') {
            const students = await Student.findAll();

            for (let student of students) {
                await Notification.create({
                    ...req.body,
                    StudentId: student.Id
                });
            }

            return res.status(201).json({
                message: "Notifications sent to all students"
            });
        }

        // General notification to all users (teachers, supervisors, mentors)
        if (Type === 'general') {
            const users = await User.findAll();

            for (let user of users) {
                await Notification.create({
                    ...req.body,
                    UserId: user.Id
                });
            }

            return res.status(201).json({
                message: "Notifications sent to all users"
            });
        }

        return res.status(400).json({ message: "Invalid Type or forWho value" });

    } catch (error) {
        return res.status(500).json({
            message: "Error creating notification",
            error: error.message
        });
    }
};

//* get personal notifcation by user id or student id
exports.getNotification = async (req, res) => {
    try {
        const { userId, studentId } = req.body;
        if (userId) {
            const notifications = await Notification.findAll({
                where: {
                    UserId: userId
                }
            });
            return res.status(200).json(notifications);
        }
        if (studentId) {
            const notifications = await Notification.findAll({
                where: {
                    StudentId: studentId
                }
            });
            return res.status(200).json(notifications);
        }
        return res.status(400).json({ message: "Invalid query parameters" });
    } catch (error) {
        return res.status(500).json({
            message: "Error fetching notifications",
            error: error.message
        });
    }
};


//* get general notifcation by students
exports.getGeneralNotification = async (req, res) => {
    try {
        const notifications = await Notification.findAll({
            where: {
                Type: 'general',
                forWho: 'students'
            }
        });
        return res.status(200).json(notifications);
    } catch (error) {
        return res.status(500).json({
            message: "Error fetching notifications",
            error: error.message
        });
    }
};


//* get general notifcation by teachers
exports.getGeneralNotificationForTeachers = async (req, res) => {
    try {
        const notifications = await Notification.findAll({
            where: {
                Type: 'general',
                forWho: 'Teachers'
            }
        });
        return res.status(200).json(notifications);
    } catch (error) {
        return res.status(500).json({
            message: "Error fetching notifications",
            error: error.message
        });
    }
};
//* get general notifcation by mentor
exports.getGeneralNotificationForMentor = async (req, res) => {
    try {
        const notifications = await Notification.findAll({
            where: {
                Type: 'general',
                forWho: 'mentors'
            }
        });
        return res.status(200).json(notifications);
    } catch (error) {
        return res.status(500).json({
            message: "Error fetching notifications",
            error: error.message
        });
    }
};


//* get general notifcation by supervisors
exports.getGeneralNotificationForSupervisors = async (req, res) => {
    try {
        const notifications = await Notification.findAll({
            where: {
                Type: 'general',
                forWho: 'supervisors'
            }
        });
        return res.status(200).json(notifications);
    } catch (error) {
        return res.status(500).json({
            message: "Error fetching notifications",
            error: error.message
        });
    }
};


//* delete notification
exports.deleteNotification = async (req, res) => {
    try {
        const { id } = req.body;
        if (!id) {
            return res.status(400).json({ message: "id is required" });
        }
        const deletedCount = await Notification.destroy({
            where: {
                Id: id, Type: 'personal'
            }
        });
        if (deletedCount === 0) {
            return res.status(404).json({ message: "Notification not found" });
        }
        return res.status(200).json({ message: "Notification deleted successfully" });
    } catch (error) {
        return res.status(500).json({
            message: "Error deleting notification",
            error: error.message
        });
    }
};

