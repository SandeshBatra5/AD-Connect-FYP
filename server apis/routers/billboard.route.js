const router = require('express').Router();
const billboardController = require('../controller/billboard.controller');

router.post("/registerbillboard",billboardController.registerbillboard);
router.post("/billboardbynumber",billboardController.billboardbynumber);
router.post("/allbillboard",billboardController.allbillboard);
router.post("/updatebillboard",billboardController.updatebillboard);
router.post("/billboardbyid",billboardController.billboardbyid);
router.post("/billboardupdateavaliable",billboardController.billboardupdateavaliable);
router.post("/deletebillboard",billboardController.deletebillboard);
router.post("/updatedbillboardrating",billboardController.updatedbillboardrating);
router.post("/allbillboardadmin",billboardController.allbillboardadmin);
router.post("/updatebillboardstatus",billboardController.updatebillboardstatus);

module.exports = router;
