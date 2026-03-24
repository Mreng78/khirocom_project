const jwt = require('jsonwebtoken');
const { User, Student } = require('../models');

module.exports = async (req, res, next) => {
    try {
        const header = req.headers.authorization;
        if (!header) {
            return res.status(401).json({ message: 'No token, authorization denied' });
        }
        const token = header.split(' ')[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decoded);

        // Check if this is a Student token
        if (decoded.Role === "Student") {
            const student = await Student.findByPk(decoded.Id);
            if (!student) {
                return res.status(404).json({ message: 'Student not found' });
            }
            console.log(student);
            req.user = student;
            req.userType = "Student";
            next();
        } else {
            // This is a User token - students endpoint shouldn't accept User tokens
            return res.status(403).json({ message: 'Access denied. Student authentication required.' });
        }
    } catch (error) {
        console.log(error);
        return res.status(401).json({ message: 'Invalid token, authorization denied' });
    }
};
