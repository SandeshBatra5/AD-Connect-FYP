const router = require('express').Router();
const resrController = require('../controller/order.contoller');

router.post("/registeroder",resrController.registeroder);
router.post("/getbyrest",resrController.getbyrest);
router.post("/getbyuser",resrController.getbyuser);
router.post("/updatestatus",resrController.updatestatus);
router.post("/allorder",resrController.allorder);

module.exports = router;