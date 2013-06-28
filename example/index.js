var express = require('express');
var jade = require('component-hooks/node_modules/jade').__express;
var app = express();

app.use(express.favicon());
app.use(express.static(__dirname + '/../public'));
app.set('views', __dirname + '/views');
app.engine('jade', jade);
app.set('view engine', 'jade');

app.get('/', function(req, res){
  res.render('index');
});

app.listen(3000);
console.log('http://localhost:3000');
