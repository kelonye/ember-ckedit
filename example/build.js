/**
  * Module dependencies.
  */
var fs = require('fs');
var path = require('path');
var builder = require('component-hooks');
var cwd = path.join(__dirname);
var out = path.join(__dirname, '/public');

// exec

module.exports = function (next){

  builder(cwd)
    .out(out)
    .copy()
    .standalone()
    .dev()
    .log()
    .end(next);

}