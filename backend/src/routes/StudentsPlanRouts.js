const express = require("express");
const router = express.Router();
const userauth = require("../middleware/UserAuth");
const studentauth=require("../middleware/StudentAuth")
const studentsplancontroller = require("../controllers/StudentPlanControoller");


router.post("/addstudentplan", studentsplancontroller.addStudentPlan);
router.get("/getstudentplans",userauth, studentsplancontroller.getStudentPlans);
router.get('/studentgetme',studentauth,studentsplancontroller.getStudentPlansByStudentId)
router.put("/updatestudentplan",userauth, studentsplancontroller.updateStudentPlan);
router.delete("/deletestudentplan",userauth, studentsplancontroller.deleteStudentPlan);
router.post("/getstudentplanbystudentid", studentsplancontroller.getStudentPlansByStudentId);
router.get("/getstudentplanbyhalaqahid",userauth, studentsplancontroller.getStudentPlansByHalaqahId);

module.exports=router