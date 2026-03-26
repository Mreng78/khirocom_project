const express = require("express");
const router = express.Router();
const Notificationcontroller = require("../controllers/NotificationContoller");


router.post("/create", Notificationcontroller.createNotification);
router.get("/getNotification", Notificationcontroller.getNotification);
router.get("/getGeneralNotificationForSupervisors", Notificationcontroller.getGeneralNotificationForSupervisors);
router.get("/getGeneralNotificationForTeachers", Notificationcontroller.getGeneralNotificationForTeachers);
router.delete("/deleteNotification", Notificationcontroller.deleteNotification);
router.get("/getGeneralNotificationForMentor", Notificationcontroller.getGeneralNotificationForMentor);
router.get("/getGeneralNotification", Notificationcontroller.getGeneralNotification);

module.exports = router;
