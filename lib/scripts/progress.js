/**
  * Module dependencies.
  */
var progress = require('ember-progress');

/**
  * Expose.
  */
module.exports = function(U) {
  U.ProgressView = Em.View.extend(progress, {
    classNames: 'component upload progress'.w(),
    classNameBindings: 'show'.w(),
    show: true,
    init: function() {
      this._super();
      U.addObserver('upload.progress', this.onuprogress.bind(this));
      U.addObserver('upload.abort', this.onabort.bind(this));
      U.addObserver('upload.error', this.onerror.bind(this));
    },
    onuprogress: function() {
      var progress = U.get('upload.progress') || 0;
      this.set('progress', progress);
      this.set('show', progress != 100);
    },
    onabort: function() {
      var abort = U.get('upload.abort');
      if (abort) {
        this.set('show', false);
      }
    },
    onerror: function() {
      var error = U.get('upload.error');
      if (error) {
        this.set('show', false);
      }
    }
  });
};
