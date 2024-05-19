const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const mongoose = require('mongoose');
const api = require('./routes/api');

const port = 3000;

const app = express();

app.use(express.static(path.join(__dirname, 'routes')));
mongoose.connect("mongodb://localhost:27017/mongo",{ useNewUrlParser: true, useUnifiedTopology: true });
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.use('/api', api);

app.listen(port, function(){
    console.log("Server running on localhost:" + port);
});

