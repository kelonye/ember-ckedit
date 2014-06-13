/**
  * Module dependencies.
  */
var Upload = require('ember-upload')('/upload');
var DropView = Upload.DropView;
var ProgressView = Upload.ProgressView;

// create drop view

DropView
  .create({
    template: Em.Handlebars.compile('upload/drop zone')
  })
  .appendTo('body');

// create progress view

ProgressView
  .create()
  .appendTo('body');
