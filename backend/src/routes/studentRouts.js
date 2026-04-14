const express = require('express');
const router = express.Router();
const studentsController = require('../controllers/StudentController');
const userauth = require('../middleware/UserAuth');
const studentauth = require('../middleware/StudentAuth');


router.get('/getallstudents', studentsController.getallstudents);
router.post('/getallstudentsbyhalaqahid', studentsController.getstudentbyhalaqatid);
router.post('/getstudentbyhalaqatid',userauth, studentsController.getstudentbyhalaqatid);
router.put('/updateme',studentauth, studentsController.updateme);
router.put('/updatestudent',userauth, studentsController.updatestudent);
router.post('/addnewstudent', studentsController.addnewstudent);
router.delete('/deletestudent',userauth, studentsController.deletestudent);
router.post('/getstudentbyid',userauth, studentsController.getstudentbyid);
router.post('/getstudentsbyname',userauth, studentsController.getstudentsbyname);
router.put('/stopstudent',userauth, studentsController.stopstudent);
router.put('/dismissstudent', studentsController.dismissstudent);
router.put('/startstudent',userauth, studentsController.startstudent);
router.get('/getstopedanddismissedstudents',userauth, studentsController.getstopedanddismissedstudents);
router.put('/movestudenttoanotherhalakat',userauth, studentsController.movestudenttoanotherhalakat);
router.post('/getstudentscountinarea',userauth, studentsController.getstudentscountinarea);
router.post('/getstudentscountbycenter',userauth, studentsController.getstudentscountbycenter);
router.post('/getstudentsbyarea',userauth,studentsController.getallstudentsbyarea)
router.post('/getstudentsbycenter',userauth, studentsController.getallstudentsbycenter);
router.post('/getstudentsbynameandhalaqatid', studentsController.getstudentsbynameandhalaqatid);
router.post('/getstudentsbystatusandhalakahid', studentsController.getstudentsbystatusandhalakahid);
router.post('/getstudentsbycategoryandhalakahid', studentsController.getstudentsbycatigoryandhalaqahid);


module.exports = router;
