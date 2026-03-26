const { MonthlyRating, MentorVisit, Student, Halakat } = require("../models");
const { Op } = require("sequelize");

//* Add Monthly Rate
exports.AddMonthlyRate = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.create(req.body);
    return res.status(200).json({ message: "Monthly Rate Added", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Get Monthly Rate
exports.GetMonthlyRate = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.findAll({
      include: [
        {
          model: Student,
          as: "RatingStudent",
          attributes: ["Name"],
          include: [
            { model: Halakat, as: "StudentHalakat", attributes: ["Name"] },
          ],
        },
      ],
    });
    if (monthlyRate.length === 0) {
      return res.status(404).json({ message: "No monthly rates found" });
    }
    return res
      .status(200)
      .json({ message: "Monthly Rate Retrieved", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Update Monthly Rate
exports.UpdateMonthlyRate = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.update(req.body, {
      where: { id: req.body.id },
    });
    return res
      .status(200)
      .json({ message: "Monthly Rate Updated", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Delete Monthly Rate
exports.DeleteMonthlyRate = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.destroy({
      where: { id: req.body.id },
    });
    return res
      .status(200)
      .json({ message: "Monthly Rate Deleted", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Get Monthly Rate By Id
exports.GetMonthlyRateById = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.findAll({
      include: [
        {
          model: Student,
          as: "RatingStudent",
          attributes: ["Name"],
          include: [
            { model: Halakat, as: "StudentHalakat", attributes: ["Name"] },
          ],
        },
      ],
    });
    if (monthlyRate.length === 0) {
      return res.status(404).json({ message: "No monthly rates found" });
    }
    return res
      .status(200)
      .json({ message: "Monthly Rate Retrieved", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* get by student id
exports.getMonthlyRateByStudentId = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.findAll({
      where: { StudentId: req.body.StudentId },
      include: [
        {
          model: Student,
          as: "RatingStudent",
          attributes: ["Name"],
          include: [
            { model: Halakat, as: "StudentHalakat", attributes: ["Name"] },
          ],
        },
      ],
    });
    
    if (monthlyRate.length === 0) {
      return res.status(404).json({ message: "No monthly rates found" });
    }
    return res
      .status(200)
      .json({ message: "Monthly Rate Retrieved", monthlyRate });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};


//* get by visit id
exports.getMonthlyRateByVisitId = async (req, res) => {
  try {
    const monthlyRate = await MonthlyRating.findAll({
      where: { MentorVisetId: req.body.MentorVisitId },
      include: [
        {
          model: MentorVisit,
          as: "RatingMentorVisit",
          attributes: ["id"],
        },
      ],
    });
    if (monthlyRate.length === 0)
      return res.status(404).json({ message: "No monthly rates found" });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
