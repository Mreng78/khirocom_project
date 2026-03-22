const { Halakat } = require('../models');
const Area = require('../models/Aria');
const User = require('../models/User');
const Student = require('../models/Student');


// *get all areas
exports.getallareas=async(req,res)=>{
    try {
        const areas=await Area.findAll({
            include:
            [
                {
                    model:User,
                    as:'Supervisor',
                    attributes:['Name']
                },
                {
                    model:User,
                    as:'Mentor',
                    attributes:['Name']
                }
            ]
        });
        return res.status(200).json({message:"تم الحصول على جميع المناطق",areas});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء الحصول على جميع المناطق",error:error.message});
    }
}

// *get area by id
exports.getareaById=async(req,res)=>{
    try {
        const area=await Area.findOne({where:{id:req.body.id},
        include:
        [
            {
                model:User,
                as:'Supervisor',
                attributes:['Name']
            },
            {
                model:User,
                as:'Mentor',
                attributes:['Name']
            }
        ]
        });
        return res.status(200).json({message:"تم الحصول على المنطقة",area});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء الحصول على المنطقة",error:error.message});
    }
}

// *create area

exports.addarea=async(req,res)=>
{
    try{
        const area=await Area.create(req.body);
        return res.status(200).json({message:"تم إضافة المنطقة",area});
    }catch(error){
        return res.status(500).json({message:"خطأ أثناء إضافة المنطقة",error:error.message});
    }
}

// *update area
exports.updatearea=async(req,res)=>{
    try {
        const {id, ...updateData} = req.body;
        const area = await Area.findByPk(id);
        if(!area) {
            return res.status(404).json({message:"المنطقة غير موجودة"});
        }
        await area.update(updateData);
        return res.status(200).json({message:"تم تحديث المنطقة بنجاح",area});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء تحديث المنطقة",error:error.message});
    }
}

// *delete area
exports.deletearea=async(req,res)=>{
    try {
        const area = await Area.findByPk(req.body.id);
        if(!area) {
            return res.status(404).json({message:"المنطقة غير موجودة"});
        }
        await area.destroy();
        return res.status(200).json({message:"تم حذف المنطقة بنجاح"});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء حذف المنطقة",error:error.message});
    }
}

// * update area
exports.updatearea=async(req,res)=>{
    try {
        const id=req.body.id;
        const area = await Area.findByPk(id);
        if(!area) {
            return res.status(404).json({message:"المنطقة غير موجودة"});
        }
        await area.update(req.body);
        return res.status(200).json({message:"تم تحديث المنطقة بنجاح",area});
    } catch (error) {
        return res.status(500).json({message:"خطأ أثناء تحديث المنطقة",error:error.message});
    }
}

//* get area by supervisor
exports.getareaBySupervisor=async(req,res)=>{
    try{
        const id = req.query.id;
        const supervisor = await User.findOne({where:{id:id, role:'مشرف'}});
        if(!supervisor) {
            return res.status(404).json({message:"الموظف غير موجود"});
        }
        const supervisorId = supervisor.Id;
        const areas = await Area.findAll({ where: {SupervisorId: supervisorId },
        include: [
            {
                model: User,
                as: 'Supervisor',
                attributes: ['Name']
            }
        ]
        });
        return res.status(200).json({message:"تم الحصول على المناطق",areas});
    }
    catch(error){
        return res.status(500).json({message:"خطأ أثناء الحصول على المناطق",error:error.message});
    }
}

//* get area by mentor
exports.getareaByMentor=async(req,res)=>{
    try{
        const id = req.body.id;
        const mentor = await User.findOne({where:{id:id}});
        if(!mentor) {
            return res.status(404).json({message:"الموظف غير موجود"});
        }
        const mentorId = mentor.Id;
        const areas = await Area.findAll({ where: {MentorId: mentorId },
        include: [
            {
                model: User,
                as: 'Mentor',
                attributes: ['Name']
            }
        ]
        });
        return res.status(200).json({message:"تم الحصول على المناطق",areas});
    }
    catch(error){
        return res.status(500).json({message:"خطأ أثناء الحصول على المناطق",error:error.message});
    }
}


//* get all students in area
exports.getallstudentscount=async(req,res)=>{
    try{
        const areaId = req.body.id || req.query.id;
        if (!areaId) {
            return res.status(400).json({message: "معرّف المنطقة مطلوب"});
        }

        const area = await Area.findByPk(areaId);
        if (!area) {
            return res.status(404).json({message: "المنطقة غير موجودة"});
        }

        const studentscount = await Student.count({
            include: [
                {
                    model: Halakat,
                    as: 'StudentHalakat',
                    where: { AriaId: areaId },
                    required: true,
                },
            ],
        });

        return res.status(200).json({message: "تم الحصول على عدد الطلاب", studentscount});
    } catch(error) {
        return res.status(500).json({message:"خطأ أثناء الحصول على الطلاب", error:error.message});
    }
}