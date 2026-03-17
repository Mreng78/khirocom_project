const Center = require("../models/Center");
const User = require("../models/User");

exports.AddCenter = async (req, res) => {
    try{
        const center = await Center.create(req.body);
        return res.status(201).json({ message: "Center created successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


exports.GetCenters = async (req, res) => {
    try{
        const centers = await Center.findAll({
            include: [
                {
                    model: User,
                    as: 'manager',
                    attributes: ['id', 'name']
                }
            ]
        });
        return res.status(200).json({ message: "Centers retrieved successfully", centers });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};

exports.GetCenterById = async (req, res) => {
    try{
        const id = req.id;
        const center = await Center.findOne(id);
        return res.status(200).json({ message: "Center retrieved successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};
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
       return res.status(200).json({ message: "Centers retrieved successfully", centers });
    }
    catch (error) {
        return res.status(500).json({ message: error.message });
    }
};
exports.updateCenter = async (req, res) => {
    try{
        const id = req.user.Id;  // من auth middleware
        const center = await Center.update(req.body, { where: { id: id } });
        return res.status(200).json({ message: "Center updated successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};
exports.deleteCenter = async (req, res) => {
    try{
        const id = req.user.Id;  // من auth middleware
        const center = await Center.destroy({ where: { id: id } });
        return res.status(200).json({ message: "Center deleted successfully", center });
    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};
