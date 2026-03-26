const express=require('express')
const router=express.Router()
const auth=require('../middleware/UserAuth')
const activitycontroller=require('../controllers/ActivitiesController')
//!const {check, validationResult}=require('express-validator')


router.post('/add',activitycontroller.addnewactivite)
router.get('/getall',activitycontroller.getAllActivities)
router.get('/getbyhalakahid',activitycontroller.getActivitiesByHalakahId)
router.delete('/delete',activitycontroller.deleteactivity)
router.put('/update',activitycontroller.updateactivity)


module.exports=router
