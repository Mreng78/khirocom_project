const express = require('express');
const router = express.Router();

const auth = require('../middleware/auth');
const areacontroller=require('../controllers/AreaController')


router.get('/getallareas',areacontroller.getallareas)
router.get('/getareabyid',areacontroller.getareaById)
router.post('/addarea',areacontroller.addarea)
router.put('/updatearea',areacontroller.updatearea)
router.delete('/deletearea',areacontroller.deletearea)
router.put('/updatearea',areacontroller.updatearea)
router.get('/getareasbysupervisor',areacontroller.getareaBySupervisor)
router.get('/getareasbymentor',areacontroller.getareaByMentor)
router.get('/getallstudentscount',areacontroller.getallstudentscount)

module.exports = router;