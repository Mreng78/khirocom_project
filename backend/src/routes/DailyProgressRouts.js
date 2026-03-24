const express = require('express');
const router = express.Router();
const dailyProgressController = require('../controllers/DailyProgressController');
const auth = require('../middleware/UserAuth');

router.get('/getall',auth, dailyProgressController.getalldailyprogress);
router.get('/getbystudentid',auth, dailyProgressController.getdailyprogressbystudentid);
router.post('/add',auth, dailyProgressController.adddailyprogress);
router.put('/update',auth, dailyProgressController.updatedailyprogress);
router.delete('/delete',auth, dailyProgressController.deletedailyprogress);
router.delete('/deletebystudentid',auth, dailyProgressController.deletedailyprogressbystudentid);


module.exports = router;
