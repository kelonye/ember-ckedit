
![](https://dl.dropbox.com/u/30162278/ember-upload.png) 

Install
---

    $ component install kelonye/ember-upload


Example
---
    
    $ make example

Use
---

```javascript
var Upload = require('ember-upload')('/upload-path');
Upload.addObserver('upload.progress', function(){
  var progress = this.get('upload.progress');
  console.log(progress);
});
```

```html
{{view Upload.ProgressView}}
{{#view Upload.DropView}}
  Upload or Drop files here
{{/view}}
```

Todo
---

X-browser.

License
---

MIT