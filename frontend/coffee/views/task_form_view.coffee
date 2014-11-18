$ =>
  class @TaskFormView extends Backbone.View
    events:
      'click #create':            'on_create'
      'click #save':              'on_save'
      'click #revert':            'on_revert'
      'click #cancel':            'on_cancel'
      'click #delete':            'on_delete'
      'change #task_description': 'on_description_change'
      'change #project':          'on_project_change'
      'change #task_due_by':      'on_due_by_change'

    template:
      _.template $('#task_form_template').html()

    render: =>
      @$el.html @template(@model.attributes)
      $.each @model.project_choices, (index, project) =>
        @$el.find('#project').append "<option value=\"#{project.href}\"> #{project.title} </option>"
      @$el.find('#project').val @model.get('project')
      resources_table_view = new ResourcesTableView(collection: @model.resources, el: @$el.find('#resources_placeholder'))
      resources_table_view.render()
      if @model.isNew()
        @$el.find('#save, #delete, #revert').hide()
      else
        @$el.find('#create, #cancel').hide()
      @

    on_create: =>
      @model.save @model.attributes,
        wait: true
        success: ->
          app.navigate 'tasks_list', trigger: true

    on_save: =>
      @model.save @model.changedAttributes(),
        wait: true
        success: =>
          Backbone.history.loadUrl()

    on_revert: =>
      app.task_view @model.get('id')

    on_cancel: =>
      app.navigate 'tasks_list', trigger: true

    on_delete: =>
      @model.destroy
        wait: true,
        success: ->
          app.navigate 'tasks_list', trigger: true

    on_description_change: (event) =>
      @model.set { 'description': $(event.target).val() }

    on_project_change: (event) =>
      @model.set { 'project': $(event.target).val() }

    on_due_by_change: (event) =>
      @model.set { 'due_by': $(event.target).val() }

