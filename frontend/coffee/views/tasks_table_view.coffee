$ =>
  class @TasksTableView extends Backbone.View
    events:
      'click #new': 'on_new'

    template:
      _.template $('#tasks_table_template').html()

    render: =>
      @$el.html(@template({ task_count: @collection.models.length }))
      $.each @collection.models, (index, item) =>
        view = new TaskRowView(model: item)
        @$el.find('tbody').append(view.render().el)
      @

    on_new: (e) =>
      e.preventDefault()
      app.navigate 'task_new', trigger: true
