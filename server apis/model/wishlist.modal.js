const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const wishlistSchema = new Schema({
    number:{
        type:String,
    },
    billboardid:{
        type:String,
    },
});

const wishlistModel = db.model('wishlist',wishlistSchema);
module.exports = wishlistModel;