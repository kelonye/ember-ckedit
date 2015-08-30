/**
 * Module dependecies.
 */
var ckedit = require('ember-ckedit');

// app

var App = Em.Application.create();

App.CkEditorComponent = Em.Component.extend(ckedit, {
  editorPath: '/ckeditor/',
  editorOpts: {},
  requireEditor: function(){
    require('./public/ckeditor/ckeditor');
  }
});


App.IndexController = Em.Controller.extend({

  post: '<h1>Title</h1><p>Content</p>',

});
