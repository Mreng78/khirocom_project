const User = require("../models/User");
const Student = require("../models/Student");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();
const { Op } = require("sequelize");
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
    const { UsernameorPhoneNumber, Password } = req.body;

    //! Search in User table first
    const user = await User.findOne({
      where: {
        [Op.or]: [
          { Username: UsernameorPhoneNumber },
          { PhoneNumber: UsernameorPhoneNumber }
        ]
      },
    });

    if (user) {
      //! User found - validate password
      let isPasswordMatch = await bcrypt.compare(Password, user.Password);
      if (!isPasswordMatch && Password === user.Password) {
        // Auto-upgrade plain text passwords to bcrypt hash for manually inserted users
        const hashedPassword = await bcrypt.hash(Password, 10);
        user.Password = hashedPassword;
        await user.save();
        isPasswordMatch = true;
      }
      
      if (!isPasswordMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
      }

      const token = jwt.sign(
        { Id: user.Id, Role: user.Role },
        process.env.JWT_SECRET,
        {
          expiresIn: "7d",
        },
      );

      // Remove password from user object before sending response
      const { Password: _, ...userWithoutPassword } = user.toJSON();

      return res.status(200).json({
        message: "Login successful",
        user: userWithoutPassword,
        token,
      });
    }

    //! User not found - search in Student table
    const student = await Student.findOne({
      where: {
        [Op.or]: [
          { Username: UsernameorPhoneNumber },
          { PhoneNumber: UsernameorPhoneNumber },
          {FatherNumber: UsernameorPhoneNumber}
        ]
      },
    });

    if (!student) {
      return res.status(400).json({ message: "User not found" });
    }

    //! Student found - validate password
    let isPasswordMatch = await bcrypt.compare(Password, student.Password);
    if (!isPasswordMatch && Password === student.Password) {
      // Auto-upgrade plain text passwords to bcrypt hash for manually inserted students
      const hashedPassword = await bcrypt.hash(Password, 10);
      student.Password = hashedPassword;
      await student.save();
      isPasswordMatch = true;
    }
    
    if (!isPasswordMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign(
      { Id: student.Id, Role: "Student" },
      process.env.JWT_SECRET,
      {
        expiresIn: "7d",
      },
    );

    //! Remove password from student object before sending response
    const { Password: _, ...studentWithoutPassword } = student.toJSON();

    return res.status(200).json({
      message: "Login successful",
      student: studentWithoutPassword,
      Role: "طالب",
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
    const users = await User.findAll({
      where: { Name: { [Op.like]: `%${name}%` } },
    });
    return res.status(200).json({ users });
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
