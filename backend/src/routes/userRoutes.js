const express = require('express');
const router = express.Router();
const usercontroller = require('../controllers/UserController');
const auth = require('../middleware/auth');



router.post('/adduser',auth, usercontroller.AddUser);
router.post('/login', usercontroller.Login);
router.get('/getusers',auth, usercontroller.GetUsers);
router.get('/getuserbyname',auth, usercontroller.GetUserByName);
router.put('/updateuser',auth, usercontroller.UpdateUser);
router.put('/updateme',auth, usercontroller.updateme);
router.get('/getusersbyroleandareaid',auth, usercontroller.getusersbyroleandareaid)


module.exports = router;