/**
  * Module dependencies.
  */
var express = require('express');
var build = require('./build');

// app

var app = express();

// middleware

//app.use(express.logger('dev'));
//app.use(express.favicon());
app.use(express.static(__dirname + '/public'));
app.use('/ckeditor', express.static(__dirname + '/vendor/ckeditor'));

app.get('/', function(req, res){
  build(function(err){
    if (err) return res.send(500, err.message);
    res.sendfile(__dirname + '/view.html');
  })
});

// bind

app.listen(3000);

console.log('listening on port 3000');
