$ =>
  class @ProjectRowView extends Backbone.View
    events:
      'click #edit':   'on_edit'
      'click #delete': 'on_delete'

    tagName: 'tr'

    template:
      _.template $('#project_row_template').html()

    render: =>
      @$el.html @template(@model.attributes)
      @

    on_edit: =>
      app.navigate "project_edit/#{@model.get('id')}", trigger: true

    on_delete: =>
      if confirm("Are you sure to delete project ##{@model.get('project_id')} and all associated tasks?")
        @model.destroy
          wait: true,
          success: ->
            Backbone.history.loadUrl()
