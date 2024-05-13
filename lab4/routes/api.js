const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Bike = require('../models/bike');

const db = "mongodb://localhost:27017/mongo";
mongoose.Promise = global.Promise;

mongoose.connect(db, { useNewUrlParser: true, useUnifiedTopology: true }, (err) => {
    if (err) {
        console.error("Помилка підключення до бази даних: ", err);
    } else {
        console.log("З'єднання з базою даних встановлено");
    }
});

router.get('/bikes', async (req, res) => {
    try {
        console.log('Get request for all bikes');
        const bikes = await Bike.find({}).exec();
        res.json(bikes);
    } catch (err) {
        console.error("Error retrieving bikes: ", err);
        res.status(500).send("Error retrieving bikes");
    }
});

router.get('/bikes/:id', async (req, res) => {
    const bikeId = req.params.id;
    try {
        console.log(`Get request for bike with ID: ${bikeId}`);
        const bike = await Bike.findById(bikeId).exec();
        if (bike) {
            res.json(bike);
        } else {
            res.status(404).send("Bike not found");
        }
    } catch (err) {
        console.error("Error retrieving bike: ", err);
        res.status(500).send("Error retrieving bike");
    }
});

router.post('/bikes', async (req, res) => {
    const newBike = new Bike({
        name: req.body.name,
        description: req.body.description,
        price: req.body.price,
        category: req.body.category,
        brand: req.body.brand,
        stock: req.body.stock,
        rating: req.body.rating
    });

    try {
        console.log('Post a new bike');
        const insertedBike = await newBike.save();
        res.json(insertedBike);
    } catch (err) {
        console.error("Error posting bike: ", err);
        res.status(500).send("Error posting bike");
    }
});

router.put('/bikes/:id', async (req, res) => {
    console.log('Update a bike');
    const bikeId = req.params.id;

    try {
        const updatedBike = await Bike.findByIdAndUpdate(
            bikeId,
            {
                $set: {
                    name: req.body.name,
                    description: req.body.description,
                    price: req.body.price,
                    category: req.body.category,
                    brand: req.body.brand,
                    stock: req.body.stock,
                    rating: req.body.rating
                },
            },
            {
                new: true,
                runValidators: true,
            }
        );

        if (!updatedBike) {
            return res.status(404).json({ error: 'Bike not found' });
        }

        res.json(updatedBike);
    } catch (err) {
        console.error("Error updating bike:", err);
        res.status(500).json({ error: "Error updating bike" });
    }
});

router.delete('/bikes/:id', async (req, res) => {
    console.log('Deleting a bike');
    const bikeId = req.params.id;

    try {
        const deletedBike = await Bike.findByIdAndDelete(bikeId);

        if (!deletedBike) {
            return res.status(404).json({ error: 'Bike not found' });
        }

        res.status(200).json({ message: 'Bike deleted successfully', bike: deletedBike });
    } catch (err) {
        console.error("Error deleting bike:", err);
        res.status(500).json({ error: "Error deleting bike" });
    }
});

