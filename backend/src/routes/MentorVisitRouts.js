const express = require("express");
const router = express.Router();
const userauth=require("../middleware/UserAuth")
const MentorVisitController=require("../controllers/MentorVisitController")


router.post("/add",userauth,MentorVisitController.AddMentorVisit);
router.get("/getAll",userauth,MentorVisitController.getAllMentorVisits);
router.get("/getByMentorId",userauth,MentorVisitController.getByMentorId);
router.get("/getByHalaqahId",userauth,MentorVisitController.getByHalaqahId);
router.get("/getByDate",userauth,MentorVisitController.getByDate);
router.put("/update",userauth,MentorVisitController.update);
router.delete("/delete",userauth,MentorVisitController.deleteMentorVisit);




module.exports=router