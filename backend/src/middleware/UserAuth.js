const jwt = require('jsonwebtoken');
const { User, Student } = require('../models');

module.exports = async (req, res, next) => {
    try {
        const header = req.headers.authorization;
        if (!header) {
            return res.status(401).json({ message: "invalid token" });
        }
        const token = header.split(' ')[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decoded);

        // Check if this is a Student token
        if (decoded.Role === "Student") {
            const student = await Student.findByPk(decoded.Id);
            if (!student) {
                return res.status(401).json({ message: "user not found" });
            }
            console.log(student);
            req.user = student;
            req.userType = "Student";
            next();
        } else {
            // This is a User token
            const user = await User.findByPk(decoded.Id);
            if (!user) {
                return res.status(401).json({ message: "user not found" });
            }
            console.log(user);
            req.user = user;
            req.userType = "User";
            next();
        }
    } catch (error) {
        console.log(error);
        return res.status(401).json({ message: "invalid token" });
    }
};