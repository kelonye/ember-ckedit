get = Em.get
set = Em.set

post = editorView = undefined

describe 'Editor:', ->

  beforeEach ->

    post = Em.Object.create
      content: '<p>content</p>'

    editorView = Em.View.create EditorMixin,
      valueBinding: 'context.content' #post's content
      context: post
    
    Em.run ->
      editorView.append()

  afterEach ->
    editorView.destroy()
    post.destroy()
  
  it "on init editor's data matches bound context attr", ->
    assert.equal get( editorView, 'value' ), '<p>content</p>'

  it.skip "editor's value changes when bound context attr changes", ->
    content = '<p>new content</p>'
    Em.run ->
      set post, 'content', content
    assert.equal get( editorView, 'value' ), content

  it.skip "bound context attr changes when editor's value changes", ->
    content = 'hey'
    Em.run ->
      editor = get editorView, 'editor'
      console.log editor
      editor.setData content
    assert.equal get( editorView, 'value' ), content
    assert.equal get( post, 'content' ), content
