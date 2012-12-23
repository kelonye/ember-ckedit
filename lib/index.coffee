get = Em.get
set = Em.set

module.exports = Em.Mixin.create

  init: ->

    inline = get @, "inline"

    if inline is true
      props = 
        attributeBindings: ["contenteditable"]
        contenteditable: "true"

    else

      props = 
        tagName: "textarea"
        classNames: ["ckeditor"]
        attributeBindings: ["name"]
        nameBinding: "elementId"

    @setProperties props
    @_super()

  template: Em.Handlebars.compile ""

  didInsertElement: ->

    @_super()

    path = document.location.pathname
    lastSlash = path.lastIndexOf("/") + 1
    abspath = path.substring(0, lastSlash)
    window.CKEDITOR_BASEPATH = "#{abspath}build/kelonye-ember-ckedit/ckeditor/"
    require "../ckeditor/ckeditor"

    that = @

    inline = get @, "inline"
    elementId = get that, "elementId"

    if inline is true

      CKEDITOR.disableAutoInline = true
      editor = CKEDITOR.inline elementId

    else

      editor = CKEDITOR.replace elementId


    content = get that, "content"
    editor.setData content
    set that, "editor", editor

    update = ->
      # update view content
      e = get that, "editor"
      content = e.getData()
      set that, "content", content

    editor.on "focus", ->
      update()

    editor.on "blur", ->
      update()

    editor.on "key", ->
      update()

  willDestroyElement: ->
    editor = get @, "editor"
    editor?.destroy true