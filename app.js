'use strict';

const express = require('express');
const morgan = require('morgan');

// Constants
const PORT = 80;
const path = __dirname + '/views/';

// App
const app = express();
const router = express.Router();

router.use(morgan('common'));

router.use(function (req,res,next) {
  next();
});

router.get('/', function(req,res){
  res.sendFile(path + 'index.html');
});


//app.use(express.static(path));
app.use('/', router);

app.listen(PORT, function() {
  console.log(`Simple node web app listening on port ${PORT}`);
});