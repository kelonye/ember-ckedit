
![](https://dl.dropbox.com/u/30162278/ember-ckedit.png)

Usage
---

See [demo](http://kelonye.github.com/#/pages/ckedit)

js

```
App.Post = DS.Model.extend
  content: DS.attr 'string'

App.PostsNewRoute = Em.Route.extend
  model: ->
    App.Post.createRecord()

  events:
    save: (post)->
      editor = get post, 'editor'
      content = editor.getData()
      set post, 'content', content
      store = get post, 'store'
      store.commit()

App.EditorView = Em.View.extend require("ember-ckedit"),
  for: 'content'
  isInline: true # make inline editor

<div data-template-name="posts/new">
  {{#with content}}
  {{view App.EditorView for="content"}}
  <button {{action save this}}></button>
  {{/with}}
</div>
```

Api
---

.for
  the view context's attr which the editor's data will be set on creation

.isInline
  opt for an inline editor

License
---

MIT