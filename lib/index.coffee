get = Em.get
set = Em.set

module.exports = Em.Mixin.create

  template: Em.Handlebars.compile ''

  init: ->

    ###
      if @isInline, make view as contenteditable,
      else make view as textarea
    ###

    isInline = get @, 'isInline'

    if isInline is true
      properties = 
        attributeBindings: ['contenteditable']
        contenteditable: 'true'

    else

      properties = 
        tagName: 'textarea'
        classNames: ['ckeditor']
        attributeBindings: ['name']
        nameBinding: 'elementId'

    @setProperties properties
    @_super()


  didInsertElement: ->

    @_super()

    #require ckeditor

    path = document.location.pathname
    lastSlash = path.lastIndexOf('/') + 1
    abspath = path.substring(0, lastSlash)
    window.CKEDITOR_BASEPATH = "#{abspath}build/kelonye-ember-ckedit/ckeditor/"
    require '../ckeditor/ckeditor'

    isInline  = get @, 'isInline'
    elementId = get @, 'elementId'

    # create editor

    if isInline is true

      CKEDITOR.disableAutoInline = true
      editor = CKEDITOR.inline elementId

    else

      editor = CKEDITOR.replace elementId

    set @, 'editor', editor

    # update editor if ...

    @addObserver 'value', ->
      @updateEditor()
    @updateEditor()

    # update context if ...

    editor.on 'focus', ->
      @updateContext()

    editor.on 'blur', ->
      @updateContext()

    editor.on 'key', ->
      @updateContext()
    
  willDestroyElement: ->
    editor = get @, 'editor'
    editor?.destroy true

    @removeObserver 'value'

  updateEditor: ->
    value = get @, 'value'
    editor.setData value

  updateContext: ->
    editor = get @, 'editor'
    value = editor.getData()
    set @, 'value', value