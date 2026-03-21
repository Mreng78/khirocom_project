const express = require('express');
const router = express.Router();

const auth=require('../middleware/auth')
const halakatcontroller=require('../controllers/HalakatController')

router.get('/getallhalaqat',auth,halakatcontroller.getallhalaqat)
router.get('/gethalaqahbyteacherid',auth,halakatcontroller.gethalaqahbyteacherid)
router.put('/updatehalaqah',auth,halakatcontroller.updatehalaqah)
router.post('/addhalaqah',auth,halakatcontroller.addhalaqah)
router.get('/gethalaqahbysarch',auth,halakatcontroller.gethalaqahbysarch)
router.get('/gethalaqahbyid',auth,halakatcontroller.gethalaqahbyid)
router.get('/gethalaqahbyareaid',auth,halakatcontroller.gethalaqahbyareaid)
router.delete('/deletehalaqah',auth,halakatcontroller.deletehalaqah)


module.exports=router
