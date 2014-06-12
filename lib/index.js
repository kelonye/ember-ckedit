require('ember');

module.exports = Em.Mixin.create({

  template: Em.Handlebars.compile(''),

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

    window.CKEDITOR_BASEPATH = this.editorPath;

    this.requireEditor();

    var isInline = this.get('isInline');
    var elementId = this.get('elementId');

    if (isInline === true) {
      CKEDITOR.disableAutoInline = true;
      var editor = CKEDITOR.inline(elementId);
    } else {
      var editor = CKEDITOR.replace(elementId);
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
