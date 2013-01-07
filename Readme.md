
![](https://dl.dropbox.com/u/30162278/ember-ckedit.png)

Usage
---

See [demo](http://kelonye.github.com/#/pages/ckedit)

js


```
App.EditorView = Em.View.extend require("ember-ckedit"),
  value: '<h1>Hi</h1>'
  isInline: true # make inline editor

```

Api
---

.value
  editor's content

.isInline
  inline editor

License
---

MIT