const router = require('express').Router();
const wishController = require('../controller/wishlist.controller');

router.post("/registerwishlist",wishController.registerwishlist);
router.post("/wishlistbyuser",wishController.wishlistbyuser);
router.post("/wishlistbynumber",wishController.wishlistbynumber);
router.post("/wishlistdelete",wishController.wishlistdelete);

module.exports = router;
