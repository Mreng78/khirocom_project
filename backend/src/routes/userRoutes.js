const express = require('express');
const router = express.Router();
const usercontroller = require('../controllers/UserController');
const auth = require('../middleware/auth');
router.post('/Adduser', auth, usercontroller.Adduser);
router.post('/login', usercontroller.Login);
router.get('/supervisors', auth, usercontroller.getsupervisor);
module.exports = router;