const jwt = require('jsonwebtoken');
const User = require('../models/User');

module.exports = async(req, res, next) => {
    try {
        const header = req.headers.authorization;
        if (!header) {
            return res.status(401).json({ message: "invalid token" });
        }
        const token = header.split(' ')[1];
        const decoded = jwt.verify(token, 'secret_key');
        console.log(decoded);
        const user = await User.findByPk(decoded.id);
        if(!user)
        {
            return res.status(401).json({ message: "user not found" });
        }
        console.log(user);
        req.user = user;
        next();
    } catch (error) {
        console.log(error);
        return res.status(401).json({ message: "invalid token" });
    }
}