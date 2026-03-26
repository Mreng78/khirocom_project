const { DailyProgress, Student } = require('../models');
const { Op } = require('sequelize');


//* get all daily progress
exports.getalldailyprogress = async (req, res) => {
    try {
        const dailyprogress = await DailyProgress.findAll({
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        if (dailyprogress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        res.status(200).json(dailyprogress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


//* get daily progress by student id
exports.getdailyprogressbystudentid = async (req, res) => {
    try {
        const studentid = req.body.id;
        const progress = await DailyProgress.findAll({
            where: { StudentId: studentid },
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        if (progress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        res.status(200).json(progress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// * add daily progress
exports.adddailyprogress = async (req, res) => {
    try {
        const dailyprogress = await DailyProgress.create(req.body);
        res.status(201).json({ message: 'Daily progress added successfully', dailyprogress });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

//* update daily progress
exports.updatedailyprogress = async (req, res) => {
    try {
        const id = req.body.id;
        const dailyprogress = await DailyProgress.update(req.body, {
            where: { Id: id }
        });
        res.status(200).json({ message: 'Daily progress updated successfully', dailyprogress });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

//* delete daily progress
exports.deletedailyprogress = async (req, res) => {
    try {
        const id = req.body.id;
        const dailyprogress = await DailyProgress.destroy({
            where: { Id: id }
        });
        res.status(200).json({ message: 'Daily progress deleted successfully', dailyprogress });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


//* delete by student id
exports.deletedailyprogressbystudentid = async (req, res) => {
    try {
        const studentid = req.body.id;
        const dailyprogress = await DailyProgress.destroy({
            where: { StudentId: studentid }
        });
        res.status(200).json({ message: 'Daily progress deleted successfully', dailyprogress });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

//* get by date 
exports.getdailyprogressbydate = async (req, res) => {
    try {
        const date = req.body.date;
        const dailyprogress = await DailyProgress.findAll({
            where: { Date: date },
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        if (dailyprogress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        res.status(200).json(dailyprogress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


//* get by date range
exports.getdailyprogressbydaterange = async (req, res) => {
    try {
        const { date1, date2 } = req.body;
        const dailyprogress = await DailyProgress.findAll({
            where: {
                Date: {
                    [Op.between]: [date1, date2]
                }
            },
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        if (dailyprogress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        res.status(200).json(dailyprogress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


//* get by date and student id
exports.getdailyprogressbydateandstudentid = async (req, res) => {
    try {
        const { date, studentid } = req.body;
        const dailyprogress = await DailyProgress.findAll({
            where: { Date: date, StudentId: studentid },
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        if (dailyprogress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        res.status(200).json(dailyprogress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};


//* get by date range and student id
exports.getdailyprogressbydaterangeandstudentid = async (req, res) => {
    try {
        const { date1, date2, studentid } = req.body;
        const dailyprogress = await DailyProgress.findAll({
            where: { Date: { [Op.between]: [date1, date2] }, StudentId: studentid },
            include: [
                {
                    model: Student,
                    as: 'ProgressStudent',
                    attributes: ['Name']
                }
            ]
        });
        res.status(200).json(dailyprogress);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

//*get all daily progress by halaqah id
exports.getdailyprogressbyhalaqahid = async (req, res) => {
    try {
        const halaqahid = req.body.halaqahid;
        
        // Find all students in the halaqah, include their daily progress
        const students = await Student.findAll({
            where: { HalakatId: halaqahid },
            attributes: ['Id', 'Name'],
            include: [
                {
                    model: DailyProgress,
                    as: 'Progresses'
                }
            ]
        });
        if (students.length === 0) {
            return res.status(404).json({ message: "No students found in this halaqah" });
        }
        // Extract all daily progress from students
        const dailyprogress = students.flatMap(student =>
            student.Progresses.map(progress => ({
                ...progress.toJSON(),
                StudentName: student.Name,
                StudentId: student.Id
            }))
        );
        if (dailyprogress.length === 0) {
            return res.status(404).json({ message: "No daily progress found" });
        }
        
        res.status(200).json({ message: "Daily progress fetched successfully", dailyprogress });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
