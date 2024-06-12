const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const billboardSchema = new Schema({
    number:{
        type:String,
    },
    price:{
        type:String,
    },
    width:{
        type:String,
    },
    height:{
        type:String,
    },
    lat:{
        type:String,
    },
    lon:{
        type:String,
    },
    des:{
        type:String,
    },
    avaliable:{
        type:String,
    },
    image:[{
        type:String,
    }],
    itemrating:{
        type:String,
    },
    itemuser:{
        type:String,
    },
    reviews:[],
    status:{
        type:String,
    },
});

const billboardModel = db.model('billboard',billboardSchema);
module.exports = billboardModel;
