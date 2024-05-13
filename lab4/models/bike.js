const mongoose = require('mongoose');

const bikeSchema = new mongoose.Schema({
    name: String,
    description:String,
    price:Number,
    category:String,
    brand:String,
    stock:Number,
    rating:Number
})

const Bike = mongoose.model('Bike', bikeSchema);
