const router = require('express').Router();
const userController = require('../controller/user.controller');

router.post("/register",userController.register);
router.post("/login",userController.login);
router.post("/getonuser",userController.getonuser);
router.post("/allusers",userController.allusers);
router.post("/deleteuser",userController.deleteuser);
router.post("/updateof",userController.updateof);

module.exports = router;
