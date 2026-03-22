const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const areacontroller=require('../controllers/AreaController')


router.get('/getallareas',auth,areacontroller.getallareas)
router.get('/getareabyid',auth,areacontroller.getareaById)
router.post('/addarea',auth,areacontroller.addarea)
router.put('/updatearea',auth,areacontroller.updatearea)
router.delete('/deletearea',auth,areacontroller.deletearea)
router.put('/updatearea',auth,areacontroller.updatearea)
router.get('/getareasbysupervisor',auth,areacontroller.getareaBySupervisor)
router.get('/getareasbymentor',auth,areacontroller.getareaByMentor)
router.get('/getallstudentscount',auth,areacontroller.getallstudentscount)

module.exports = router;