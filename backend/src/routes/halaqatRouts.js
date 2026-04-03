const express = require('express');
const router = express.Router();

const auth=require('../middleware/UserAuth')
const halakatcontroller=require('../controllers/HalakatController')

router.get('/getallhalaqat',auth,halakatcontroller.getallhalaqat)
router.post('/gethalaqahbyteacherid',halakatcontroller.gethalaqahbyteacherid)
router.put('/updatehalaqah',auth,halakatcontroller.updatehalaqah)
router.post('/addhalaqah',auth,halakatcontroller.addhalaqah)
router.post('/gethalaqahbysarch',auth,halakatcontroller.gethalaqahbysarch)
router.post('/gethalaqahbyid',auth,halakatcontroller.gethalaqahbyid)
router.post('/gethalaqahbyareaid',auth,halakatcontroller.gethalaqahbyareaid)
router.delete('/deletehalaqah',auth,halakatcontroller.deletehalaqah)


module.exports=router
