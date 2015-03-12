$ =>
  class @ProjectFormView extends Backbone.View
    events:
      'click #create':               'on_create'
      'click #save':                 'on_save'
      'click #revert':               'on_revert'
      'click #cancel':               'on_cancel'
      'click #delete':               'on_delete'
      'change #project_description': 'on_description_change'
      'change #image_upload':        'on_image_upload_change'

    template:
      _.template $('#project_form_template').html()

    render: =>
      @$el.html @template(@model.attributes)
      @display_png(@model.attributes.image) if @model.attributes.image
      if @model.isNew()
        @$el.find('#save, #delete, #revert').hide()
      else
        @$el.find('#create, #cancel').hide()
      @

    display_png: (data) =>
      @$el.find('#project_image').attr('src', 'data:image/png;base64,' + data)

    on_create: =>
      @model.save @model.attributes,
        wait: true
        success: ->
          app.navigate 'project_list', trigger: true

    on_save: =>
      @model.save @model.changedAttributes(),
        wait: true
        success: =>
          app.navigate 'project_list', trigger: true

    on_revert: =>
      app.project_view @model.get('id')

    on_cancel: =>
      app.navigate 'project_list', trigger: true

    on_delete: =>
      @model.destroy
        wait: true,
        success: ->
          app.navigate 'project_list', trigger: true

    on_description_change: (event) =>
      @model.set {'description': $(event.target).val()}

    on_image_upload_change: (event) =>
      fileReader = new FileReader
      fileReader.onload = (event) =>
        @model.set { image: btoa(event.target.result) }
        @display_png @model.get('image')
      fileReader.readAsBinaryString(event.target.files[0])
