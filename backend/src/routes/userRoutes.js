const express = require('express');
const router = express.Router();
const usercontroller = require('../controllers/UserController');

router.post('/adduser', usercontroller.AddUser);
router.post('/login', usercontroller.Login);

module.exports = router;