const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();


exports.AddUser = async (req, res) =>
{
  try {
    const hashedPassword = await bcrypt.hash(req.body.Password, 10);
    const user = await User.create({
      Username: req.body.Username,
      Password: hashedPassword,
      Name: req.body.Name,
      PhoneNumber: req.body.PhoneNumber,
      AvtarUrl: req.body.AvtarUrl,
      Gender: req.body.Gender,
      Age: req.body.Age,
      EducationLevel: req.body.EducationLevel,
      Role: req.body.Role,
      Salary: req.body.Salary || 0,
      Address: req.body.Address || "",
      AvtarUrl: req.body.AvtarUrl || "",
      Gender: req.body.Gender || "ذكر",
      Age: req.body.Age || 0,
      EducationLevel: req.body.EducationLevel || "",
    });
    return res.status(201).json({ message:`تم إضافة ${req.body.Name} بنجاح`, user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

exports.GetUsers = async (req, res) => {
  try {
    const users = await User.findAll();
    return res.status(200).json({ users });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

exports.Login = async (req, res) => {
  try {

    const { Username, Password } = req.body;
    
    const user = await User.findOne({
      where: { Username: Username },
    });
    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }
    const isPasswordMatch = await bcrypt.compare(Password, user.Password);

    if (!isPasswordMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }
    const token = jwt.sign({ Id: user.Id }, process.env.JWT_SECRET, {
      expiresIn: "7d",
    });
    return res.status(200).json({ message: "Login successful",
       userId: user.Id,
       Name: user.Name,
       PhoneNumber: user.PhoneNumber,
       Role: user.Role,
       AvatarUrl: user.AvtarUrl,
       Gender: user.Gender,
       Age: user.Age,
       EducationLevel: user.EducationLevel,
       Address: user.Address,
       token });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};




exports.GetUserByName=async(req,res)=>{
  try {
    const name = req.body.Name;
    const user = await User.findOne({
      where: { Name:name },
    });
    return res.status(200).json({ user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
}

exports.updateme=async(req,res)=>{
  try{
    if (req.body.Password) {
      req.body.Password = await bcrypt.hash(req.body.Password, 10);
    }
    const allowedUpdates = ["Name","Username","Password","PhoneNumber", "AvtarUrl", "Gender", "Age", "EducationLevel", "Address"];
    const updates = {};
    for (let key of allowedUpdates) {
      if (req.body[key]) {
        updates[key] = req.body[key];
      }
    }
    const user = req.user;
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    await user.update(updates);
    return res.status(200).json({ message: "User updated successfully", user: user.toJSON() });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
}

exports.UpdateUser=async(req,res)=>{
  try{
    const allowedUpdates = ["Name", "PhoneNumber", "AvtarUrl", "Gender", "Age", "EducationLevel", "Role", "Salary", "Address"];
    const user = await User.findOne({
      where: { Id: req.params.Id },
    });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    const updatedUser = await User.update(req.body, {
      where: { Id: req.params.Id },
    });
    return res.status(200).json({ message: "User updated successfully", updatedUser: user.toJSON() });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};


exports.DeleteUser=async(req,res)=>{
  try{
    const id = req.body.Id;
    const user = await User.destroy({
      where: { Id: id },
    });
    return res.status(200).json({ message: "User deleted successfully", user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
}
