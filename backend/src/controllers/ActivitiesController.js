const { Activity, Halakat } = require("../models");
const { Op } = require("sequelize");

//* add activity
exports.addnewactivite = async (req, res) => {
  try {
    const activity = await Activity.create(req.body);
    return res
      .status(200)
      .json({ message: "the activity was added", activity });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* get all
exports.getAllActivities = async (req, res) => {
  try {
    const activities = await Activity.findAll({
      include: [
        {
          model: Halakat,
          as: "Halakat",
          attributes: ["Name"],
        },
      ],
    });
    if (activities.length === 0) {
      return res.status(404).json({ message: "No activities found" });
    }
    return res
      .status(200)
      .json({ message: "activities retrieved successfully", activities });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* get by halakah id
exports.getActivitiesByHalakahId = async (req, res) => {
  try {
    const activities = await Activity.findAll({
      where: {
        HalaqahId: req.body.id,
      },
      include: [
        {
          model: Halakat,
          as: "Halakat",
          attributes: ["Name"],
        },
      ],
    });
    if (activities.length === 0) {
      return res.status(404).json({ message: "No activities found" });
    }
    return res
      .status(200)
      .json({ message: "activities retrieved successfully", activities });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

//* delete activity
exports.deleteactivity=async(req,res)=>
{
  try{
    const activity = await Activity.destroy({
      where: {
        id: req.body.id,
      },
    });
    return res.status(200).json({ message: "activity deleted successfully" });
  }catch(error){
    return res.status(500).json({ message: error.message });
  }
}


//* update activity
exports.updateactivity=async(req,res)=>
{
  try{
    const activity = await Activity.update(req.body,{
      where: {
        id: req.body.id,
      },
    });
    return res.status(200).json({ message: "activity updated successfully" });
  }catch(error){
    return res.status(500).json({ message: error.message });
  }
}
