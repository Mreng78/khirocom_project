const express = require("express");
const router = express.Router();
const graduateController = require("../controllers/GraduateController");
const auth = require("../middleware/UserAuth");

router.post("/addGraduate", auth, graduateController.addGraduate);
router.get("/getAllGraduates", auth, graduateController.getAllGraduates);
router.get("/getGraduateById", auth, graduateController.getGraduateById);
router.delete("/deleteGraduate", auth, graduateController.deleteGraduate);
router.put("/updateGraduate", auth, graduateController.updateGraduate);
router.get("/getGraduateByHalaqahId", auth, graduateController.getGraduateByHalaqahId);
router.get("/getAllGraduatesInCenter", auth, graduateController.getAllGraduatesInCenter);
router.get("/getGraduateByArea", auth, graduateController.getGraduateByArea);
router.get('/getGraduateByName', auth, graduateController.getGraduateByName);


module.exports = router;
