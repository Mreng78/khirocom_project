const express = require('express');
const router = express.Router();
const usercontroller = require('../controllers/UserController');
const auth = require('../middleware/UserAuth');



router.post('/adduser', usercontroller.AddUser);
router.post('/login', usercontroller.Login);
router.get('/getusers', auth, usercontroller.GetUsers);
router.post('/getuserbyname', auth, usercontroller.GetUserByName);
router.put('/updateuser', auth, usercontroller.UpdateUser);
router.put('/updateme', auth, usercontroller.updateme);
router.post('/getusersbyroleandareaid', auth, usercontroller.getusersbyroleandareaid);


module.exports = router;