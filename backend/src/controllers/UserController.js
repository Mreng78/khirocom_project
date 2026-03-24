const User = require("../models/User");
const Student = require("../models/Student");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();

//* update me endpoint

exports.updateme = async (req, res) => {
  try {
    const allowedUpdates = [
      "Name",
      "Username",
      "Password",
      "PhoneNumber",
      "AvtarUrl",
      "Gender",
      "Age",
      "EducationLevel",
      "Address",
    ];
    const updates = {};

    for (let key of allowedUpdates) {
    
      if (req.body.hasOwnProperty(key)) {
        
        if (key === "Password" && req.body[key]) {
          updates[key] = await bcrypt.hash(req.body[key], 10);
        } else {
          updates[key] = req.body[key];
        }
      }
    }

    const user = req.user;
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (Object.keys(updates).length === 0) {
      return res.status(400).json({ message: "No fields to update" });
    }

    await user.update(updates);
    return res
      .status(200)
      .json({ message: "User updated successfully", user: user.toJSON() });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// !for admin to control users information

// *Add User
exports.AddUser = async (req, res) => {
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
    return res
      .status(201)
      .json({ message: `تم إضافة ${req.body.Name} بنجاح`, user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *Get All Users
exports.GetUsers = async (req, res) => {
  try {
    const users = await User.findAll();
    return res.status(200).json({ users });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *Login
exports.Login = async (req, res) => {
  try {
    const { Username, Password } = req.body;

    //! Search in User table first
    const user = await User.findOne({
      where: { Username: Username },
    });

    if (user) {
      //! User found - validate password
      const isPasswordMatch = await bcrypt.compare(Password, user.Password);
      if (!isPasswordMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
      }

      const token = jwt.sign({ Id: user.Id, Role: user.Role }, process.env.JWT_SECRET, {
        expiresIn: "7d",
      });

      return res.status(200).json({
        message: "Login successful",
        userId: user.Id,
        Name: user.Name,
        PhoneNumber: user.PhoneNumber,
        Role: user.Role,
        AvatarUrl: user.AvtarUrl,
        Gender: user.Gender,
        Age: user.Age,
        EducationLevel: user.EducationLevel,
        Address: user.Address,
        token,
      });
    }

    //! User not found - search in Student table
    const student = await Student.findOne({
      where: { Username: Username },
    });

    if (!student) {
      return res.status(400).json({ message: "User not found" });
    }

    //! Student found - validate password
    const isPasswordMatch = await bcrypt.compare(Password, student.Password);
    if (!isPasswordMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign({ Id: student.Id, Role: "Student" }, process.env.JWT_SECRET, {
      expiresIn: "7d",
    });

    return res.status(200).json({
      message: "Login successful",
      userId: student.Id,
      Name: student.Name,
      PhoneNumber: student.phoneNumber,
      Role: "طالب",
      AvatarUrl: student.ImageUrl,
      Gender: student.Gender,
      Age: student.Age,
      EducationLevel: null,
      Address: null,
      token,
    });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *Get User By Name
exports.GetUserByName = async (req, res) => {
  try {
    const name = req.body.Name;
    const user = await User.findOne({
      where: { Name: name },
    });
    return res.status(200).json({ user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *Update User
exports.UpdateUser = async (req, res) => {
  try {
    const id = req.body.Id;
    const user = await User.update(req.body, {
      where: { Id: id },
    });
    return res.status(200).json({ message: "User updated successfully", user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *Delete User
exports.DeleteUser = async (req, res) => {
  try {
    const id = req.body.Id;
    const user = await User.destroy({
      where: { Id: id },
    });
    return res.status(200).json({ message: "User deleted successfully", user });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

// *get user by role and areaid

exports.getusersbyroleandareaid = async (req, res) => {
  try {
    const role = req.body.Role;
    const areaId = req.body.AreaId;
    const users = await User.findAll({
      where: { Role: role, AreaId: areaId },
    });
    return res.status(200).json({ users });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};
