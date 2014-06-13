module.exports = function(U) {
  U.DropView = Em.View.extend({
    classNames: 'component upload drop'.w(),
    classNameBindings: 'over'.w(),
    over: false,
    didInsertElement: function() {
      this._super();
      var el = this.$()[0];
      this.set('el', el);
      el.addEventListener('click', this.onclick.bind(this), false);
      el.addEventListener('dragenter', this.ondragenter.bind(this), false);
      el.addEventListener('dragover', this.ondragover.bind(this), false);
      el.addEventListener('dragleave', this.ondragleave.bind(this), false);
      el.addEventListener('drop', this.ondrop.bind(this), false);
    },
    ondragenter: function(e) {
      return this.set('over', true);
    },
    ondragover: function(e) {
      e.preventDefault();
      return false;
    },
    ondragleave: function(e) {
      return this.set('over', false);
    },
    ondrop: function(e) {
      e.stopPropagation();
      e.preventDefault();
      this.set('over', false);
      this.upload(e.dataTransfer.files);
    },
    onclick: function(){
      var picker = require('file-picker');
      var opts = {
        multiple: this.multiple,
        accept: this.accept,
        directory: this.directory
      };
      picker(opts, this.upload);
    },
    upload: function(files){
      var n = files.length;
      console.log(n);
      while (n--){
        console.log(n);
        U.Upload.create().upload(files[n]);
      }
    }
  });
};
