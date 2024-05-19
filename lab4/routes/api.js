const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

// const Bike = require('../models/bike');


mongoose.connect("mongodb://localhost:27017/mongo");

mongoose.connection.on('connected', () =>{
    console.log("Connected success");
});

mongoose.connection.on('error', (err) =>{
    console.log("Connection failed" + err);
});

// Запит для отримання всіх велосипедів
router.get('/bikes', async (req, res) => {
    try {
        const bikes = await mongoose.connection.db.collection('bikes').find({}).toArray();
        res.json(bikes);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Запит для отримання велосипеду за ID
router.get('/bikes/:id', async (req, res) => {
    try {
        const bike = await mongoose.connection.db.collection('bikes').findOne({ id: (req.params.id) });
        if (!bike) {
            return res.status(404).json({ message: 'Bike not found' });
        }
        res.json(bike);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Запит для створення нового велосипеду
router.post('/bikes', async (req, res) => {
    const newBike = req.body;
    try {
        const result = await mongoose.connection.db.collection('bikes').insertOne(newBike);
        if (result.insertedCount === 1 && result.ops && result.ops.length === 1) {
            res.status(201).json(result.ops[0]);
        } else {
            res.status(400).json({ message: 'Failed to insert bike' });
        }
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});



// Запит для оновлення велосипеду за ID
router.put('/bikes/:id', async (req, res) => {
    try {
        const result = await mongoose.connection.db.collection('bikes').updateOne(
            { id: (req.params.id) },
            { $set: req.body }
        );
        if (result.modifiedCount === 0) {
            return res.status(404).json({ message: 'Bike not found' });
        }
        res.json({ message: 'Bike updated' });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Запит для видалення велосипеду за ID
router.delete('/bikes/:id', async (req, res) => {
    try {
        const result = await mongoose.connection.db.collection('bikes').deleteOne({ id: (req.params.id) });
        if (result.deletedCount === 0) {
            return res.status(404).json({ message: 'Bike not found' });
        }
        res.json({ message: 'Bike deleted' });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});


module.exports = router;