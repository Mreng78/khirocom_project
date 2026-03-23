const jwt = require('jsonwebtoken');
const Student = require('../models/Student');


module.exports = async (req, res, next) => {
    try{
        const header = req.headers.authorization;
        if(!header)
        {
            return res.status(401).json({ message: 'No token, authorization denied' });
        }
        const token=header.split(' ')[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const student = await Student.findByPk(decoded.id);
        console.log(decoded);
        if(!student)
        {
            return res.status(404).json({ message: 'Student not found' });
        }
        console.log(student);
        req.student = student;
        next();
    }catch(error){
        return res.status(401).json({ message: 'Invalid token, authorization denied' });
    }
};
