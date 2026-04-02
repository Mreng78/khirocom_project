const express = require('express');
const router = express.Router();
const dailyProgressController = require('../controllers/DailyProgressController');
const auth = require('../middleware/UserAuth');

router.get('/getall',auth, dailyProgressController.getalldailyprogress);
router.post('/getbystudentid',auth, dailyProgressController.getdailyprogressbystudentid);
router.post('/add',auth, dailyProgressController.adddailyprogress);
router.put('/update',auth, dailyProgressController.updatedailyprogress);
router.delete('/delete',auth, dailyProgressController.deletedailyprogress);
router.delete('/deletebystudentid',auth, dailyProgressController.deletedailyprogressbystudentid);
router.post('/getbydate',auth, dailyProgressController.getdailyprogressbydate);
router.post('/getbydaterange',auth, dailyProgressController.getdailyprogressbydaterange);
router.post('/getbydateandstudentid',auth, dailyProgressController.getdailyprogressbydateandstudentid);
router.post('/getbydaterangeandstudentid',auth, dailyProgressController.getdailyprogressbydaterangeandstudentid);


module.exports = router;
