const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");



exports.AddUser = async (req, res)=>
{

    try {
        const Password = req.body.Password;
        const hashedPassword = await bcrypt.hash(Password, 10);
        req.body.Password = hashedPassword;

        const user = await User.create(req.body);
        return res.status(201).json({ message: "User created successfully", user });
    } catch (error) {
        return res.status(500).json({ error: error.message });
    }
    
}
exports.Login = async (req, res) => {
    try {

        const { Username, Password } = req.body;

        const user = await User.findOne({
            where: { Username: Username }
        });

        if (!user) {
            return res.status(400).json({ message: "User not found" });
        }

        const isPasswordMatch = await bcrypt.compare(Password, user.Password);

        if (!isPasswordMatch) {
            return res.status(400).json({ message: "Invalid credentials" });
        }

        const token = jwt.sign(
            { id: user.Id },
            process.env.JWT_SECRET,
            { expiresIn: "1d" }
        );

        console.log(token);

        return res.status(200).json({
            message: "Login successful",
            user,
            token
        });

    } catch (err) {

        res.status(500).json({
            error: err.message
        });

    }
};


