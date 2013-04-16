require 'ember'

module.exports = Em.Mixin.create

  template: Em.Handlebars.compile ''

  init: ->

    ###
      if @isInline, make view as contenteditable, else make view as textarea
    ###

    isInline = @get 'isInline'

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

    # require ckeditor

    path = document.location.pathname
    lastSlash = path.lastIndexOf('/') + 1
    abspath = path.substring(0, lastSlash)
    window.CKEDITOR_BASEPATH = "#{abspath}build/kelonye-ember-ckedit/ckeditor/"
    require '../ckeditor/ckeditor'

    isInline  = @get 'isInline'
    elementId = @get 'elementId'

    # create editor

    if isInline is true

      CKEDITOR.disableAutoInline = true
      editor = CKEDITOR.inline elementId

    else

      editor = CKEDITOR.replace elementId

    # set data as context value

    context = @get 'context'
    _for = @get 'for'
    if _for
      value = context.get "#{_for}"
      editor.setData value
    context.set 'editor', editor

  willDestroyElement: ->
    context = @get 'context'
    editor = context.get 'editor'
    editor.destroy false