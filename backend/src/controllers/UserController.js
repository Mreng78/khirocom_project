const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();
const Student = require("../models/student");
const Manager = require("../models/Manager");
const Supervisor = require("../models/Supervisor");
const Mentor = require("../models/Mentor");
const Teacher = require("../models/Teacher");

exports.Adduser = async (req, res) => {
  try {
    const { role, Username, Password, Name, Email, PhoneNumber, Role: userRole } = req.body;

    if (role === "مشرف") {
      const { Supervisor: supervisorData } = req.body;
      const hashedPassword = await bcrypt.hash(Password, 10);

      const user = await User.create({
        Name,
        Username,
        Password: hashedPassword,
        Email,
        PhoneNumber,
        Role: userRole,
      });

      const supervisor = await Supervisor.create({
        ...supervisorData,
        User_Id: user.Id,
      });

      return res.status(201).json({
        message: "User and Supervisor created successfully",
        user,
        supervisor,
      });
    } else if (role === "طالب") {
      const { Student: studentData } = req.body;
      const hashedPassword = await bcrypt.hash(Password, 10);

      const user = await User.create({
        Name,
        Username,
        Password: hashedPassword,
        Email,
        PhoneNumber,
        Role: userRole,
      });

      const student = await Student.create({
        ...studentData,
        User_Id: user.Id,
      });

      return res.status(201).json({
        message: "User and Student created successfully",
        user,
        student,
      });
    } else if (role === "موجه") {
      const { Mentor: mentorData } = req.body;
      const hashedPassword = await bcrypt.hash(Password, 10);

      const user = await User.create({
        Name,
        Username,
        Password: hashedPassword,
        Email,
        PhoneNumber,
        Role: userRole,
      });

      const mentor = await Mentor.create({
        ...mentorData,
        User_Id: user.Id,
      });

      return res.status(201).json({
        message: "User and Mentor created successfully",
        user,
        mentor,
      });
    } else if (role === "مدرس") {
      const { Teacher: teacherData } = req.body;
      const hashedPassword = await bcrypt.hash(Password, 10);

      const user = await User.create({
        Name,
        Username,
        Password: hashedPassword,
        Email,
        PhoneNumber,
        Role: userRole,
      });

      const teacher = await Teacher.create({
        ...teacherData,
        User_Id: user.Id,
      });

      return res.status(201).json({
        message: "User and Teacher created successfully",
        user,
        teacher,
      });
    } else {
      return res.status(400).json({ message: "Invalid role" });
    }
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

exports.getsupervisor = async (req, res) => {
  try {
    const supervisors = await Supervisor.findAll({
      include: [
        {
          model: User,
          as: "User",
        },
      ],
    });
    return res.status(200).json({ supervisors });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};
exports.Login = async (req, res) => {
  try {
    const role = req.body.role;

    const { Username, Password } = req.body;

    let user;

    if (role === "admin") {
      user = await User.findOne({
        where: { Username: Username },
      });
    } else if (role === "manager") {
      user = await User.findOne({
        where: { Username: Username },
        include: [
          {
            model: Manager,
            as: "Managers",
          },
        ],
      });
    } else if (role === "student") {
      user = await User.findOne({
        where: { Username: Username },
        include: [
          {
            model: Student,
            as: "Students",
          },
        ],
      });
    } else if (role === "supervisor") {
      user = await User.findOne({
        where: { Username: Username },
        include: [
          {
            model: Supervisor,
            as: "Supervisors",
          },
        ],
      });
    } else if (role === "mentor") {
      user = await User.findOne({
        where: { Username: Username },
        include: [
          {
            model: Mentor,
            as: "Mentors",
          },
        ],
      });
    } else {
      return res.status(400).json({ message: "Invalid role" });
    }

    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const isPasswordMatch = await bcrypt.compare(Password, user.Password);

    if (!isPasswordMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign({ Id: user.Id }, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });

    console.log(token);

    return res.status(200).json({
      message: "Login successful",
      user,
      token,
    });
  } catch (err) {
    res.status(500).json({
      error: err.message,
    });
  }
};
