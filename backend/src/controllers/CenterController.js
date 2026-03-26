const Center = require("../models/Center");
const User = require("../models/User");
const { Op } = require("sequelize");

//* Add Center
exports.AddCenter = async (req, res) => {
    try{
        const center = await Center.create(req.body);
        return res.status(201).json({ message: "Center created successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


//* Get All Centers
exports.GetCenters = async (req, res) => {
    try{
        const centers = await Center.findAll({
            include: [
                {
                    model: User,
                    as: 'manager',
                    attributes: ['name']
                }
            ]
        });
        if (centers.length === 0) {
            return res.status(404).json({ message: "No centers found" });
        }
        return res.status(200).json({ message: "Centers retrieved successfully", centers });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

//* Get Center By Id
exports.GetCenterById = async (req, res) => {
    try{
        const id = req.id;
        const center = await Center.findOne({ where: { id: id } });
         if (!center) {
            return res.status(404).json({ message: "Center not found" });
        }
        return res.status(200).json({ message: "Center retrieved successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

//* Get Centers By Manager Id
exports.getCenterbymanagerid = async (req, res) => {
    try{
       const managerId = req.user.Id;
       const centers = await Center.findAll({
        where: { managerId: managerId },
        include: [
            {
                model: User,
                as: 'manager',
                attributes: ['id', 'name']
            }
        ]
       });
       if (centers.length === 0) {
           return res.status(404).json({ message: "No centers found" });
       }
       return res.status(200).json({ message: "Centers retrieved successfully", centers });
    }
    catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


//* Update Center
exports.updateCenter = async (req, res) => {
    try{
        const id = req.user.Id;  // !من auth middleware
        const center = await Center.update(req.body, { where: { id: id } });
        if (!center) {
            return res.status(404).json({ message: "Center not found" });
        }
        return res.status(200).json({ message: "Center updated successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


//* Delete Center
exports.deleteCenter = async (req, res) => {
    try{
        const id = req.user.Id;  //! من auth middleware
        if (!center) {
            return res.status(404).json({ message: "Center not found" });
        }
        const center = await Center.destroy({ where: { id: id } });
        return res.status(200).json({ message: "Center deleted successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


//* Get Centers By Name
exports.GetCentersByName = async (req, res) => {
    try{
        const name = req.query.name;
        const centers = await Center.findAll({
            where: {
                name: {
                    [Op.like]: `%${name}%`
                }
            }
        });
        return res.status(200).json({ message: "Centers retrieved successfully", centers });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};
