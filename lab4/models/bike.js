const mongoose = require('mongoose');

const bikeSchema = new mongoose.Schema({
    id : Number,
    name: String,
    description:String,
    price:Number,
    category:String,
    brand:String,
    stock:Number,
    rating:Number
})

const Bike = mongoose.model('Bike', bikeSchema);
