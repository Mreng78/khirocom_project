const { Graduate, Student, Halakat, Center, Aria } = require("../models");
const { Op } = require("sequelize");

//* Add Graduate
exports.addGraduate = async (req, res) => {
  try {
    const graduate = await Graduate.create(req.body);
    res.status(201).json({ message: "Graduate added successfully", graduate });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get All Graduates
exports.getAllGraduates = async (req, res) => {
  try {
    const graduates = await Graduate.findAll({
      include: [
        {
          model: Student,
          as: "Student",
          attributes: ["Name"],
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
            },
          ],
        },
      ],
    });
    res
      .status(200)
      .json({ message: "Graduates fetched successfully", graduates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get Graduate By Id
exports.getGraduateById = async (req, res) => {
  try {
    const graduate = await Graduate.findByPk(req.body.id, {
      include: [
        {
          model: Student,
          as: "Student",
          attributes: ["Name"],
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
            },
          ],
        },
      ],
    });
    if (!graduate) {
      return res.status(404).json({ message: "Graduate not found" });
    }
    res
      .status(200)
      .json({ message: "Graduate fetched successfully", graduate });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Update Graduate
exports.updateGraduate = async (req, res) => {
  try {
    const [updatedCount] = await Graduate.update(req.body, {
      where: {
        Id: req.body.id,
      },
    });
    if (updatedCount === 0) {
      return res.status(404).json({ message: "Graduate not found" });
    }
    res.status(200).json({ message: "Graduate updated successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Delete Graduate
exports.deleteGraduate = async (req, res) => {
  try {
    const deletedCount = await Graduate.destroy({
      where: {
        Id: req.body.id,
      },
    });
    if (deletedCount === 0) {
      return res.status(404).json({ message: "Graduate not found" });
    }
    res.status(200).json({ message: "Graduate deleted successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get Graduate By Student Name
exports.getGraduateByName = async (req, res) => {
  try {
    const graduates = await Graduate.findAll({
      include: [
        {
          model: Student,
          as: "Student",
          where: {
            Name: {
              [Op.like]: `%${req.body.name}%`,
            },
          },
          attributes: ["Name"],
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
            },
          ],
        },
      ],
    });
    res
      .status(200)
      .json({ message: "Graduates fetched successfully", graduates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get Graduates By Halaqah Id
exports.getGraduateByHalaqahId = async (req, res) => {
  try {
    const graduates = await Graduate.findAll({
      include: [
        {
          model: Student,
          as: "Student",
          attributes: ["Name"],
          where: {
            HalakatId: req.body.HalaqahId,
          },
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
            },
          ],
        },
      ],
    });
    res
      .status(200)
      .json({ message: "Graduates fetched successfully", graduates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get all graduates in center
exports.getAllGraduatesInCenter = async (req, res) => {
  try {
    const graduates = await Graduate.findAll({
      include: [
        {
          model: Student,
          as: "Student",
          attributes: ["Name"],
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
              include: [
                {
                  model: Aria,
                  as: "Aria",
                  attributes: ["Name"],
                  where: {
                    CenterId: req.body.CenterId,
                  },
                },
              ],
            },
          ],
        },
      ],
    });
    res
      .status(200)
      .json({ message: "Graduates fetched successfully", graduates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//* Get Graduate By Area
exports.getGraduateByArea = async (req, res) => {
  try {
    const graduates = await Graduate.findAll({
      include: [
        {
          model: Student,
          as: "Student",
          attributes: ["Name"],
          include: [
            {
              model: Halakat,
              as: "StudentHalakat",
              attributes: ["Name"],
              include: [
                {
                  model: Aria,
                  as: "Aria",
                  attributes: ["Name"],
                  where: {
                    Id: req.body.AreaId
                  }
                }
              ]
            }
          ]
        }
      ]
    });
    res
      .status(200)
      .json({ message: "Graduates fetched successfully", graduates });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
