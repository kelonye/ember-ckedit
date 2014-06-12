var express = require('component-hooks/node_modules/express');
var build = require('./build');

var app = express();

app.use(express.favicon());
app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
  build(function(err){
    if (err) return res.send(500, err.message);
    res.sendfile(__dirname + '/view.html');
  })
});

app.listen(3000);
console.log('http://localhost:3000');
