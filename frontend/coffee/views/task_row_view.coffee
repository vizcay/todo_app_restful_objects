$ =>
  class @TaskRowView extends Backbone.View
    tagName: 'tr'

    events:
      'click #mark_done': 'on_mark_done'
      'click #edit':      'on_edit'
      'click #delete':    'on_delete'

    template:
      _.template $('#task_row_template').html()

    render: =>
      @$el.html @template(@model.attributes)
      @

    on_mark_done: =>
      @model.set({completed: true})
      @model.save
        success:
          Backbone.history.loadUrl()

    on_edit: =>
      app.navigate "task_view/#{@model.get('id')}", trigger: true

    on_delete: =>
      if confirm("Are you sure to delete task ##{@model.get('task_id')}?")
        @model.destroy
          wait: true,
          success: ->
            Backbone.history.loadUrl()
