const express = require("express");
const router = express.Router();
const auth=require("../middleware/UserAuth")
const MonthlyRateController=require('../controllers/MonthlyRateController')


router.post("/add",auth,MonthlyRateController.AddMonthlyRate);
router.get("/getall",auth,MonthlyRateController.GetMonthlyRate);
router.put("/update",auth,MonthlyRateController.UpdateMonthlyRate);
router.delete("/delete",auth,MonthlyRateController.DeleteMonthlyRate);
router.get("/getbyid",auth,MonthlyRateController.GetMonthlyRateById);
router.get("/getbystudentid",auth,MonthlyRateController.getMonthlyRateByStudentId);
router.get("/getbyvisitid",auth,MonthlyRateController.getMonthlyRateByVisitId);


module.exports = router;
