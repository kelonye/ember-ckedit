/**
  * Module dependencies.
  */
require('ember');

// mixin

module.exports = Em.Mixin.create({

  events: [
    'focus',
    'blur',
    'key',
    // 'change',
  ],

  init: function(){

    // if @isInline, make view as contenteditable, else make view as textarea

    var isInline = this.get('isInline');

    if (isInline === true) {
      var properties = {
        attributeBindings: ['contenteditable'],
        contenteditable: 'true'
      };
    } else {
      var properties = {
        tagName: 'textarea',
        classNames: ['ckeditor'],
        attributeBindings: ['name'],
        nameBinding: 'elementId'
      };
    }

    this.setProperties(properties);

    this._super();

  },

  setup: function() {

    // render editor
        
    var self = this;
    var isInline = this.get('isInline');
    var opts = this.get('editorOpts');
    var elementId = this.get('elementId');

    if (isInline === true) {
      CKEDITOR.disableAutoInline = true;
      var editor = CKEDITOR.inline(elementId, opts);
    } else {
      var editor = CKEDITOR.replace(elementId, opts);
    }

    this.get('events').forEach(function(event){
      editor.on(event, self.send.bind(self, 'onvalue'));
    });

    editor.setData(this.get('value') || '');

    this.set('editor', editor);

  }.on('didInsertElement'),

  teardown: function() {
    this.get('editor').destroy(false);
  }.on('willDestroyElement'),

  actions: {

    onvalue: function(){
      Em.run.next(this, function(){
        if (this.get('isDestroyed')) return;
        this.set('value', this.get('editor').getData());
      });
    },

  }
});
