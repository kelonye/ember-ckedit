get = Em.get
set = Em.set

module.exports = Em.Mixin.create

  init: ->

    ###
      if isInline,
      make view as contenteditable,
      else make view as textarea
    ###

    isInline = get @, "isInline"

    if isInline is true
      properties = 
        attributeBindings: ["contenteditable"]
        contenteditable: "true"

    else

      properties = 
        tagName: "textarea"
        classNames: ["ckeditor"]
        attributeBindings: ["name"]
        nameBinding: "elementId"

    @setProperties properties
    @_super()

  template: Em.Handlebars.compile ""

  didInsertElement: ->

    @_super()

    #require ckeditor

    path = document.location.pathname
    lastSlash = path.lastIndexOf("/") + 1
    abspath = path.substring(0, lastSlash)
    window.CKEDITOR_BASEPATH = "#{abspath}build/kelonye-ember-ckedit/ckeditor/"
    require "../ckeditor/ckeditor"

    that = @

    isInline = get @, "isInline"
    elementId = get that, "elementId"

    # create editor

    if isInline is true

      CKEDITOR.disableAutoInline = true
      editor = CKEDITOR.inline elementId

    else

      editor = CKEDITOR.replace elementId

    # set editor's data as view's content

    content = get that, "content"
    editor.setData content
    set that, "editor", editor

    # update view's content
    
    # sets view's content as editor's data
    updateViewContent = ->
      editor = get that, "editor"
      content = editor.getData()
      set that, "content", content

    # event handlers
    editor.on "focus", ->
      updateViewContent()

    editor.on "blur", ->
      updateViewContent()

    editor.on "key", ->
      updateViewContent()

  willDestroyElement: ->
    editor = get @, "editor"
    editor?.destroy true