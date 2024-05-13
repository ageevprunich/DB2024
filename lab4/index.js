const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const { default: mongoose } = require('mongoose');


const port = 3000;

const app = express();

app.use(express.static(path.join(__dirname, 'routes')));
mongoose.connect("mongodb://localhost:27017/mongo",{ useNewUrlParser: true, useUnifiedTopology: true });
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

mongoose.connection.on('connected', () =>{
    console.log("Connected success");
});

mongoose.connection.on('error', (err) =>{
    console.log("Connection failed" + err);
});

// Запит для отримання всіх велосипедів
app.get('/api/bikes', async (req, res) => {
    try {
        const bikes = await mongoose.connection.db.collection('bikes').find({}).toArray();
        res.json(bikes);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Запит для отримання велосипеду за ID
app.get('/api/bikes/:id', async (req, res) => {
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
app.post('/api/bikes', async (req, res) => {
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
app.put('/api/bikes/:id', async (req, res) => {
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
app.delete('/api/bikes/:id', async (req, res) => {
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

app.listen(port, function(){
    console.log("Server running on localhost:" + port);
});



app.get('/bikes', async (req, res) => {
    try {
        console.log('Get request for all bikes');
        const bikes = await Bike.find({}).exec();
        res.json(bikes);
    } catch (err) {
        console.error("Error retrieving bikes: ", err);
        res.status(500).send("Error retrieving bikes");
    }
});



