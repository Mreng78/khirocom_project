const {
  MentorVisit,
  User,
  MonthlyRating,
  Student,
  Halakat,
} = require("../models");
const { Op } = require("sequelize");

//* Add Mentor Visit
exports.AddMentorVisit = async (req, res) => {
  try {
    const mentorVisit = await MentorVisit.create(req.body);
    return res.status(200).json({ message: "Mentor Visit Added", mentorVisit });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Add Mentor Visit with Monthly Rating

//* Get All Mentor Visits
exports.getAllMentorVisits = async (req, res) => {
  try {
    const mentorVisits = await MentorVisit.findAll({
      include: [
        { model: User, as: "Mentor", attributes: ["Name"] },
        { model: Halakat, as: "Halakat", attributes: ["Name"] },
      ],
    });
    return res
      .status(200)
      .json({ message: "Mentor Visits Retrieved", mentorVisits });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};


//* get by mentor id
exports.getByMentorId = async (req, res) => {
  try {
     const mentorVisits = await MentorVisit.findAll({
      include: [
        { model: User, as: "Mentor", attributes: ["Name"] },
        { model: Halakat, as: "Halakat", attributes: ["Name"] },
      ],
      where: { MentorId: req.body.MentorId },
    });
    return res.status(200).json({ message: "Mentor Visits Retrieved", mentorVisits });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* get by date
exports.getByDate = async (req, res) => {
  try {
    const mentorVisits = await MentorVisit.findAll({
      include: [
        { model: User, as: "Mentor", attributes: ["Name"] },
        { model: Halakat, as: "Halakat", attributes: ["Name"] },
      ],
      where: { Date: req.body.Date },
    });
    return res.status(200).json({ message: "Mentor Visits Retrieved", mentorVisits });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//*get by halaqah id
exports.getByHalaqahId = async (req, res) => {
  try {
    const mentorVisits = await MentorVisit.findAll({
      include: [
        { model: User, as: "Mentor", attributes: ["Name"] },
        { model: Halakat, as: "Halakat", attributes: ["Name"] },
      ],
      where: { HalakatId: req.body.HalaqahId },
    });
    return res.status(200).json({ message: "Mentor Visits Retrieved", mentorVisits });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* update mentor visit
exports.update = async (req, res) => {
  try {
    const visit = await MentorVisit.update(req.body, {
      where: { Id: req.body.Id },
    });
    return res.status(200).json({ message: "Mentor Visit Updated", visit: visit });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* Delete Mentor Visit
exports.deleteMentorVisit = async (req, res) => {
  try {
    const deletedCount = await MentorVisit.destroy({
      where: { Id: req.body.Id },
    });
    return res.status(200).json({ message: "Mentor Visit Deleted", deletedCount });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};


