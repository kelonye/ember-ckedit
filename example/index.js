var ckedit = require('ember-ckedit');

window.App = Em.Application.create();

App.EditorView = Em.View.extend(ckedit, {
  editorPath: '/ckeditor/',
  requireEditor: function(){
    require('./public/ckeditor/ckeditor');
  }
});

App.IndexController = Em.Controller.extend({
  hasEditor: function() {
    var editor = this.get('editor');
    if (editor) {
      editor.on('focus', this.updateContent.bind(this));
      editor.on('blur', this.updateContent.bind(this));
      editor.on('key', this.updateContent.bind(this));
    }
  }.observes('editor'),
  updateContent: function() {
    var editor = this.get('editor');
    var content = editor.getData();
    this.set('content', content);
  }
});
