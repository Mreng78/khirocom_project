const express = require("express");
const router = express.Router();
const userauth = require("../middleware/UserAuth");
const studentauth=require("../middleware/StudentAuth")
const studentsplancontroller = require("../controllers/StudentPlanControoller");


router.post("/addstudentplan", studentsplancontroller.addStudentPlan);
router.get("/getstudentplans", studentsplancontroller.getStudentPlans);
router.put("/updatestudentplan", studentsplancontroller.updateStudentPlan);
router.delete("/deletestudentplan", studentsplancontroller.deleteStudentPlan);
router.get("/getstudentplanbystudentid", studentsplancontroller.getStudentPlanByStudentId);
router.get("/getstudentplanbyhalaqahid", studentsplancontroller.getStudentPlansByHalaqahId);


module.exports=router