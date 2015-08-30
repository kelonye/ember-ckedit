/**
  * Module dependencies.
  */
require('ember');

// mixin

module.exports = Em.Mixin.create({

  init: function() {

    /**
      * if @isInline,
      * make view as contenteditable,
      * else make view as textarea
      */

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

  didInsertElement: function() {

    this._super();

    var opts = this.get('editorOpts');
    var isInline = this.get('isInline');
    var elementId = this.get('elementId');

    if (isInline === true) {
      CKEDITOR.disableAutoInline = true;
      var editor = CKEDITOR.inline(elementId, opts);
    } else {
      var editor = CKEDITOR.replace(elementId, opts);
    }

    var context = this.get('context');
    var _for = this.get('for');
    if (_for) {
      var value = context.get(_for);
      editor.setData(value);
    }
    context.set('editor', editor);

  },
  willDestroyElement: function() {
    var context = this.get('context');
    var editor = context.get('editor');
    editor.destroy(false);
  }
});
