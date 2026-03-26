const express = require('express');
const router = express.Router();
const studentsController = require('../controllers/StudentController');
const userauth = require('../middleware/UserAuth');
const studentauth = require('../middleware/StudentAuth');


router.get('/getallstudents',userauth, studentsController.getallstudents);
router.get('/getstudentbyhalaqatid',userauth, studentsController.getstudentbyhalaqatid);
router.put('/updateme',studentauth, studentsController.updateme);
router.put('/updatestudent',userauth, studentsController.updatestudent);
router.post('/addnewstudent', studentsController.addnewstudent);
router.delete('/deletestudent',userauth, studentsController.deletestudent);
router.get('/getstudentbyid',userauth, studentsController.getstudentbyid);
router.get('/getstudentsbyname',userauth, studentsController.getstudentsbyname);
router.put('/stopstudent',userauth, studentsController.stopstudent);
router.put('/dismissstudent',userauth, studentsController.dismissstudent);
router.put('/startstudent',userauth, studentsController.startstudent);
router.get('/getstopedanddismissedstudents',userauth, studentsController.getstopedanddismissedstudents);
router.put('/movestudenttoanotherhalakat',userauth, studentsController.movestudenttoanotherhalakat);
router.get('/getstudentscountinarea',userauth, studentsController.getstudentscountinarea);
router.get('/getstudentscountbycenter',userauth, studentsController.getstudentscountbycenter);
router.get('/getstudentsbyarea',studentsController.getallstudentsbyarea)
router.get('/getstudentsbycenter', studentsController.getallstudentsbycenter);

module.exports = router;
