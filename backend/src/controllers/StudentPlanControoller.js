const { StudentPlane, Student } = require("../models");
const { Op } = require("sequelize");

//* Add Student Plan


exports.addStudentPlan = async (req, res) => {
  try {
    const plan = await StudentPlane.create(req.body);
    return res.status(201).json({ success: true, message: "Plan added successfully", data: plan });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};


//* Get Student Plans
exports.getStudentPlans = async (req, res) => {
  try {
    const plans = await StudentPlane.findAll(
      {
        include: [{ model: Student, as: "PlaneStudent", attributes: ["Name"] }],
      }
    );
    return res
      .status(200)
      .json({ success: true, message: "Plans fetched successfully", data: plans });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};



//* get plane py student id
exports.getStudentPlan = async (req, res) => {
  try {
    const plan = await StudentPlane.findAll({
      where: {
        StudentId: req.body.StudentId,
      },
      include: [{ model: Student, as: "PlaneStudent", attributes: ["Name"] }],
    });
    return res.status(200).json({ success: true, message: "Plans fetched successfully", data: plan });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};


//* Update Student Plan
exports.updateStudentPlan = async (req, res) => {
  try {
    const planid = req.body.planId;
    
    const existingPlan = await StudentPlane.findOne({
      where: { id: planid },
    });
    
    if (!existingPlan) {
      return res.status(404).json({ message: "Plan not found for this student" });
    }
    
    await StudentPlane.update(req.body, {
      where: { id: planid },
    });


    return res.status(200).json({ success: true, message: "Plan updated successfully", planId: planid });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};


//* Delete Student Plan
exports.deleteStudentPlan = async (req, res) => {
  try {
    const plan = await StudentPlane.destroy({
      where: {
        id: req.body.Id || req.body.planId,
      },
    });
    return res.status(200).json({ success: true, message: "Plan deleted successfully", plan });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};

exports.getStudentPlansByStudentId = async (req, res) => {
  try {
    const studentId = req.body.StudentId || (req.user ? req.user.Id : null);
    
    if (!studentId) {
      return res.status(400).json({ success: false, message: "StudentId is required" });
    }

    const plan = await StudentPlane.findAll({
      where: {
        StudentId: studentId,
      },
      include: [{ model: Student, as: "PlaneStudent", attributes: ["Name"] }],
    });
    return res.status(200).json({ success: true, message: "Plan fetched successfully", data: plan });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};

//* get all studentsplan by halaqah id
exports.getStudentPlansByHalaqahId = async (req, res) => {
  try {
    const halaqahId = req.body.HalaqahId;
    
    // Find all students in the halaqah, include their plans
    const students = await Student.findAll({
      where: { HalakatId: halaqahId },
      attributes: ["Name"],
      include: [
        { 
          model: StudentPlane, 
          as: "Planes"
        }
      ]
    });
    
    // Extract all plans from students
    const plans = students.flatMap(student => 
      student.Planes.map(plan => ({
        ...plan.toJSON(),
        StudentName: student.Name,
        StudentId: student.Id
      }))
    );
    
    return res.status(200).json({ success: true, message: "Plans fetched successfully", data: plans });
  } catch (error) {
    return res.status(500).json({ success: false, message: "Error", error: error.message });
  }
};
