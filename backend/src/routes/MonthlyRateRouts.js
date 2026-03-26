const express = require("express");
const router = express.Router();
const auth=require("../middleware/UserAuth")
const MonthlyRateController=require('../controllers/MonthlyRateController')


router.post("/add",MonthlyRateController.AddMonthlyRate);
router.get("/getall",MonthlyRateController.GetMonthlyRate);
router.put("/update",MonthlyRateController.UpdateMonthlyRate);
router.delete("/delete",MonthlyRateController.DeleteMonthlyRate);
router.get("/getbyid",MonthlyRateController.GetMonthlyRateById);
router.get("/getbystudentid",MonthlyRateController.getMonthlyRateByStudentId);
router.get("/getbyvisitid",MonthlyRateController.getMonthlyRateByVisitId);


module.exports = router;
