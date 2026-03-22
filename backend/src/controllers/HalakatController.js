const { Student, User, Aria } = require("../models");
const Halakat = require("../models/Halakat");
const { fn, col } = require("sequelize");
const { Op } = require("sequelize");

// *add new halaqah

exports.addhalaqah = async (req, res) => {
  try {
    const halaqah = await Halakat.create({
      Name: req.body.Name,
      studentsGender: req.body.studentsGender,
      type: req.body.type,
      TeacherId: req.body.TeacherId,
      AriaId: req.body.AriaId,
    });
    res.status(201).json({ message: "Halaqah created successfully", halaqah });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// *update halaqah
exports.updatehalaqah = async (req, res) => {
  try {
    const id = req.body.Id;
    const halaqah = await Halakat.update(req.body, { where: { id: Id } });
    return res.status(200).json({ message: "تم تعديل بيانات الحلقة", halaqah });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "خطأ أثناء تعديل بيانات الحلقة", error });
  }
};

//* delete halaqah

exports.deletehalaqah = async (req, res) => {
  try {
    const id = req.body.Id;
    const halaqah = await Halakat.destroy({ where: { id: Id } });
    return res.status(200).json({ message: "تم حذف الحلقة", halaqah });
  } catch (error) {
    return res.status(500).json({ message: "خطأ أثناء حذف الحلقة", error });
  }
};

// * get all halaqah

exports.getallhalaqat = async (req, res) => {
  try {
    const halaqat = await Halakat.findAll({
      attributes: {
        include: [[fn("COUNT", col("HalakatStudents.Id")), "studentsCount"]],
      },
      include: [
        {
          model: User,
          as: "Teacher",
          attributes: ["Name"],
        },
        {
          model: Aria,
          as: "Aria",
          attributes: ["Name"],
        },
        {
          model: Student,
          as: "HalakatStudents",
          attributes: [],
        },
      ],
      group: ["Halakat.Id", "Teacher.Id", "Aria.Id"],
    });

    return res
      .status(200)
      .json({ message: "تم الحصول على جميع الحلقات", halaqat });
  } catch (error) {
    return res
      .status(500)
      .json({
        message: "خطأ أثناء الحصول على جميع الحلقات",
        error: error.message,
      });
  }
};

// *get halaqah py teacher id

exports.gethalaqahbyteacherid = async (req, res) => {
  try {
    const teacherId = req.body.TeacherId;
    const halaqat = await Halakat.findOne({
      where: { TeacherId: teacherId },
      include: [
        {
          model: User,
          as: "Teacher",
          attributes: ["Name"],
        },
        {
          model: Aria,
          as: "Aria",
          attributes: ["Name"],
        },
        {
          model: Student,
          as: "HalakatStudents",
          attributes: ["Id"],
        },
      ],
    });

    if (!halaqat) {
      return res.status(404).json({ message: "لم يتم العثور على حلقة" });
    }

    // إضافة عدد الطلاب
    const result = halaqat.get({ plain: true });
    result.studentsCount = result.HalakatStudents ? result.HalakatStudents.length : 0;
    delete result.HalakatStudents;

    return res.status(200).json({ message: "تم الحصول على الحلقة", halaqat: result });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "خطأ أثناء الحصول على الحلقات", error: error.message });
  }
};

// *get halaqah by serch of name

exports.gethalaqahbysarch = async (req, res) => {
  try {
    const name = req.body.Name;
    const halaqat = await Halakat.findAll({
      where: { Name: { [Op.like]: `%${name}%` } },
      include: [
        {
          model: User,
          as: "Teacher",
          attributes: ["Name"],
        },
        {
          model: Aria,
          as: "Aria",
          attributes: ["Name"],
        },
        {
          model: Student,
          as: "HalakatStudents",
          attributes: ["Id"],
        },
      ],
    });

    // إضافة عدد الطلاب لكل حلقة
    const result = halaqat.map(h => {
      const plain = h.get({ plain: true });
      plain.studentsCount = plain.HalakatStudents ? plain.HalakatStudents.length : 0;
      delete plain.HalakatStudents;
      return plain;
    });

    return res.status(200).json({ message: "تم الحصول على الحلقات", halaqat: result });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "خطأ أثناء الحصول على الحلقة", error: error.message });
  }
};

// *get halaqah by id
exports.gethalaqahbyid = async (req, res) => {
  try {
    const id = req.body.Id;
    const halaqah = await Halakat.findOne({
      where: { id: id },
      include: [
        {
          model: User,
          as: "Teacher",
          attributes: ["Name"],
        },
        {
          model: Aria,
          as: "Aria",
          attributes: ["Name"],
        },
        {
          model: Student,
          as: "HalakatStudents",
          attributes: ["Id"],
        },
      ],
    });

    if (!halaqah) {
      return res.status(404).json({ message: "لم يتم العثور على الحلقة" });
    }

    return res.status(200).json({ message: "تم الحصول على الحلقة", halaqah });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "خطأ أثناء الحصول على الحلقة", error: error.message });
  }
};

// * get halaqah by area id
exports.gethalaqahbyareaid=async (req, res) => {
  try {
    const areaId = req.body.AriaId;
    const halaqat = await Halakat.findAll({
      where: { AriaId: areaId },
      include: [
        {
          model: User,
          as: "Teacher",
          attributes: ["Name"],
        },
        {
          model: Aria,
          as: "Aria",
          attributes: ["Name"],
        },
        {
          model: Student,
          as: "HalakatStudents",
          attributes: ["Id"],
        },
      ],
    });
    return res.status(200).json({ message: "تم الحصول على الحلقات", halaqat });
  } catch (error) {
    return res
      .status(500)
      .json({ message: "خطأ أثناء الحصول على الحلقات", error: error.message });
  }
};

// * delete halaqah
exports.deletehalaqah = async (req, res) => {
  try {
    const id = req.body.Id;
    const halaqah = await Halakat.destroy({
      where: { id: id }
    });
    return res.status(200).json({ message: "تم حذف الحلقه بنجاح", halaqah });
  } catch (error) {
    return res.status(500).json({ message: "خطأ أثناء حذف الحلقة", error });
  }
};
