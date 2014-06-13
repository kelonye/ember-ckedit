module.exports = function(U) {
  U.Upload = Em.Object.extend({
    init: function() {
      this._super();
      U.set('upload', this);
    },
    upload: function(file) {
      this.set('file', file);
      var to = U.get('to');
      file.slice = file.slice || file.webkitSlice;
      var body = new FormData;
      body.append('file', file);
      var req = this.req = new XMLHttpRequest;
      req.onloadstart = this.onloadstart.bind(this);
      req.upload.onprogress = this.onprogress.bind(this);
      req.onload = this.onload.bind(this);
      req.onerror = this.onerror.bind(this);
      req.onabort = this.onabort.bind(this);
      req.onloadend = this.onloadend.bind(this);
      req.open('POST', to);
      return req.send(body);
    },
    onloadstart: function(e) {
      return this.set('loadstart', true);
    },
    onprogress: function(e) {
      var progress;

      progress = void 0;
      if (e.lengthComputable) {
        progress = e.loaded / e.total * 100;
      }
      return this.set('progress', progress);
    },
    onload: function(e) {
      return this.set('load', true);
    },
    onerror: function(e) {
      this.set('error', true);
      return this.destroy();
    },
    onabort: function(e) {
      this.set('abort', true);
      return this.destroy();
    },
    onloadend: function(e) {
      this.set('loadend', true);
      return this.destroy();
    }
  });
};
