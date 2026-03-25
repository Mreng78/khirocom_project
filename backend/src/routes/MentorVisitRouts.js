const express = require("express");
const router = express.Router();
const userauth=require("../middleware/UserAuth")
const MentorVisitController=require("../controllers/MentorVisitController")


router.post("/add",MentorVisitController.AddMentorVisit);
router.get("/getAll",MentorVisitController.getAllMentorVisits);
router.get("/getByMentorId",MentorVisitController.getByMentorId);
router.get("/getByHalaqahId",MentorVisitController.getByHalaqahId);
router.get("/getByDate",MentorVisitController.getByDate);
router.put("/update",MentorVisitController.update);
router.delete("/delete",MentorVisitController.deleteMentorVisit);




module.exports=router