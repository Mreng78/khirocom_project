const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Halakat, Aria, Center } = require('../models');
const Student = require('../models/Student');
const { Op } = require('sequelize');
 
//* update me
exports.updateme = async (req, res) => {
    try {
        const id = req.body.id || req.student.id;
        const allowedFields = ['Name', 'Username', 'Password', 'phoneNumber', 'Age', 'ImageUrl'];
        const hashedPassword = await bcrypt.hash(req.body.Password, 10);
        console.log('Hashed Password:', hashedPassword);
        req.body.Password = hashedPassword;
        
        if (req.body.Username) {
            const existingStudent = await Student.findOne({ where: { Username: req.body.Username } });
            if (existingStudent && existingStudent.Id !== id) {
                return res.status(400).json({ message: "اسم المستخدم موجود مسبقا" });
            }
        }

        const updates = {};
        allowedFields.forEach(field => {
            if (req.body[field]) {
                updates[field] = req.body[field];
            }
        });
        const result = await Student.update(updates, { where: { id: id } });
        return res.status(200).json({ message: "تم تحديث البيانات", result });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء تحديث البيانات", error: error.message });
    }
}

//* add new students
exports.addnewstudent = async (req, res) => {
    try {
        // Hash the password before creating the student
        const hashedPassword = await bcrypt.hash(req.body.Password, 10);
        console.log('Hashed Password:', hashedPassword);
        req.body.Password = hashedPassword;
        
        const student = await Student.create(req.body);
        return res.status(200).json({ message: "تم إضافة الطالب", student });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء إضافة الطالب", error: error.message });
    }
};


//* get all students with halakat name
exports.getallstudents=async(req,res)=>
{
    try {
        const students = await Student.findAll(
            {
                attributes: { exclude: ['Password'] },
                include:
                [
                    {
                        model:Halakat,
                        as:'StudentHalakat',
                        attributes: ['Name']
                    }
                ]
            }
            
        );
        if (students.length === 0) {
            return res.status(404).json({message:"No students found"});
        }
        return res.status(200).json({message:"تم الحصول على الطلاب",students});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء الحصول على الطلاب", error:error.message});
    }
}

//* get student by halaqat id
exports.getstudentbyhalaqatid=async(req,res)=>
{
    try{
        const halaqatid = req.body.id;
        const students = await Student.findAll({
            where: { HalakatId: halaqatid },
            attributes: { exclude: ['Password','dismissedReason','dismissedDate'] }
        });
        if (students.length === 0) {
            return res.status(404).json({message:"No students found in this halaqah"});
        }
        return res.status(200).json({message:"تم الحصول على الطلاب",students});
    }catch(error)
    {
        return res.status(500).json({message:"خطأ أثناء الحصول على الطلاب", error:error.message});
    }
}


//*update student
exports.updatestudent = async (req, res) => {
    try {
        const id = req.body.id;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update(req.body);
        return res.status(200).json({ message: "تم تحديث البيانات", student });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء تحديث البيانات", error: error.message });
    }
};

//* delete student
exports.deletestudent = async (req, res) => {
    try{
        const id = req.body.id;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.destroy();
        return res.status(200).json({ message: "تم حذف الطالب" });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء حذف الطالب", error: error.message });
    }
};

//* get student by id
exports.getstudentbyid = async (req, res) => {
    try{
        const id = req.body.id;
        const student = await Student.findOne({ where: { id: id } },
            {
                attributes: { exclude: ['Password','dismissedReason','dismissedDate'] },
                include:
                [
                    {
                        model: Halakat,
                        as: 'StudentHalakat',
                        attributes: ['Name']
                    }
                ]
            }
        );
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        return res.status(200).json({ message: "تم الحصول على الطالب", student });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء الحصول على الطالب", error: error.message });
    }
};

//* get students by name
exports.getstudentsbyname = async (req, res) => {
    try {
        const name = req.body.Name;
        console.log('Search name received:', name);
        
        if (!name) {
            return res.status(400).json({ message: "اسم الطالب مطلوب" });
        }
        
        const students = await Student.findAll({
            where: {
                Name: {
                    [Op.like]: `%${name}%`
                }
            },
            attributes: { exclude: ['Password','dismissedReason','dismissedDate'] },
        });
        if (students.length === 0) {
            return res.status(404).json({ message: "No students found with this name" });
        }
        
        console.log('Students found:', students.length);
        return res.status(200).json({ message: "تم الحصول على الطلاب", students });
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ message: "خطأ أثناء الحصول على الطلاب", error: error.message });
    }
};


//* update current memorization
exports.updatecurrentmemorization = async (req, res) => {
    try{
        const id = req.body.id;
        const current_Memorization_Sorah = req.body.current_Memorization_Sorah;
        const current_Memorization_Aya = req.body.current_Memorization_Aya;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update({ current_Memorization_Sorah, current_Memorization_Aya });
        return res.status(200).json({ message: "تم تحديث البيانات", student });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء تحديث البيانات", error: error.message });
    }
};

//* dismiss student
exports.dismissstudent = async (req, res) => {
    try{
        const id = req.body.id;
        const reason = req.body.reason;
        const date = req.body.date;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update({status:'مفصول', DismissedReason:reason, DismissedDate:date});
        return res.status(200).json({ message: "تم فصل الطالب   " });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء فصل الطالب", error: error.message });
    }
};


//* stop student
exports.stopstudent = async (req, res) => {
    
    try{
        const id = req.body.id;
        const reason = req.body.reason;
        const date = req.body.date;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update({status:'منقطع', stopReason:reason, stopDate:date});
        return res.status(200).json({ message: "تم إيقاف الطالب   " });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء إيقاف الطالب", error: error.message });
    }
};

exports.startstudent = async (req, res) => {
    try{
        const id = req.body.id;
        const halakatid = req.body.halaqatid;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update({status:'مستمر', stopReason:null, stopDate:null, HalakatId:halakatid});
        return res.status(200).json({ message: "تم استئناف الطالب   " });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء استئناف الطالب", error: error.message });
    }
};

////* get stoped and dismissed students
exports.getstopedanddismissedstudents = async (req, res) => {
    try {
        const students = await Student.findAll({
            where: { status: ['مفصول', 'منقطع']  },
            attributes: { exclude: ['Password']},
            include:
            [
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    attributes: ['Name']
                }
            ]
        });
        return res.status(200).json({ message: "تم الحصول على الطلاب", students });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء الحصول على الطلاب", error: error.message });
    }
};

//* move student to another halakat
exports.movestudenttoanotherhalakat = async (req, res) => {
    try{
        const id = req.body.id;
        const halakatid = req.body.halaqatid;
        const student = await Student.findOne({ where: { id: id } });
        if (!student) {
            return res.status(404).json({ message: "الطالب غير موجود" });
        }
        await student.update({HalakatId:halakatid});
        return res.status(200).json({ message: "تم نقل الطالب   ", student });
    } catch (error) {
        return res.status(500).json({ message: "خطأ أثناء نقل الطالب", error: error.message });
    }
};

//* get students count in area
exports.getstudentscountinarea = async (req, res) => {
    try{
        const areaid = req.body.areaid;
        const count = await Student.count({
            include:[
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    where: { AriaId: areaid },
                    required: true
                }
            ]
        });
        return res.status(200).json({ message: "تم الحصول على عدد الطلاب", count });
    }catch (error) {
        return res.status(500).json({ message: "خطأ أثناء الحصول على عدد الطلاب", error: error.message });
    }
};


//* get students count by center
exports.getstudentscountbycenter = async (req, res) => {
    try{
        const centerid = req.body.centerid;
        const count = await Student.count({
            include:[
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    required: true,
                    include: [
                        {
                            model: Aria,
                            as: 'Aria',
                            where: { CenterId: centerid },
                            required: true
                        }
                    ]
                }
            ]
        });
        return res.status(200).json({ message: "تم الحصول على عدد الطلاب", count });
    }catch (error) {
        return res.status(500).json({ message: "خطأ أثناء الحصول على عدد الطلاب", error: error.message });
    }
};


//* get all student in area
exports.getallstudentsbyarea=async(req,res)=>
{
    try{
        const areaid = req.body.areaid;
        const students = await Student.findAll({
            attributes: { exclude: ['Password'] },
            include: [
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    where: { AriaId: areaid }
                }
            ]
        });
        if (students.length === 0) {
            return res.status(404).json({ message: "No students found in this area" });
        }
        return res.status(200).json({ message: "تم الحصول على الطلاب", students });
    }catch (error)
    {
        return res.status(500).json({ message: "خطأ أثناء الحصول على الطلاب", error: error.me
 });
    }
}
//* get all students in center
exports.getallstudentsbycenter=async(req,res)=>
{
    try{
        const centerid = req.body.centerid || req.body.CenterId || req.query.centerid || req.query.CenterId;
        if (!centerid) {
            return res.status(400).json({ message: "centerid or CenterId is required" });
        }
        const students = await Student.findAll({
            attributes: { exclude: ['Password'] },
            include: [
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    required: true,
                    include: [
                        {
                            model: Aria,
                            as: 'Aria',
                            required: true,
                            where: { CenterId: centerid }
                        }
                    ]
                }
            ]
        });
        if (students.length === 0) {
            return res.status(404).json({ message: "No students found in this center" });
        }
        return res.status(200).json({ message: "تم الحصول على الطلاب", students });
    }catch (error)
    {
        return res.status(500).json({ message: "خطأ أثناء الحصول على الطلاب", error: error.message });
    }
}
