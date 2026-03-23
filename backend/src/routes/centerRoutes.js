const express = require("express");
const router = express.Router();
const aut = require("../middleware/UserAuth");
const centerController = require("../controllers/CenterController");


router.post("/addCenter", aut, centerController.AddCenter);
router.get("/getCenters", aut, centerController.GetCenters);
router.get("/getCenterById", aut, centerController.GetCenterById);
router.get("/getCenterbymanagerid", aut, centerController.getCenterbymanagerid);
router.put("/updateCenter", aut, centerController.updateCenter);
router.delete("/deleteCenter", aut, centerController.deleteCenter);
module.exports = router;
