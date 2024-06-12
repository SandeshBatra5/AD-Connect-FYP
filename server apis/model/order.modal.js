const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const orderSchema = new Schema({
    billboardid:{
        type:String,
    },
    custnumber:{
        type:String,
    },
    ownernumber:{
        type:String,
    },
    status:{
        type:String,
    },
    date:[
        {
            type: String,
        },
    ],
});

const orderModel = db.model('order',orderSchema);
module.exports = orderModel;