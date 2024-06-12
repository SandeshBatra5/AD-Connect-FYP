const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routers/user.route");
const billboardRoute = require("./routers/billboard.route");
const orderRoute = require("./routers/order.route");
const walletRoute = require("./routers/wallet.route");
const wishlistRoute = require("./routers/wishlist.route");
const chatRoute = require("./routers/chat.route");

const app = express();
app.use(bodyParser.json());
app.use("/",UserRoute);
app.use("/",billboardRoute);
app.use("/",orderRoute);
app.use("/",walletRoute);
app.use("/",wishlistRoute);
app.use("/",chatRoute);

module.exports = app;
