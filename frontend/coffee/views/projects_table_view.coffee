$ =>
  class @ProjectsTableView extends Backbone.View
    events:
      'click #new': 'on_new'

    template:
      _.template $('#projects_table_template').html()

    render: =>
      @$el.html(@template({ project_count: @collection.models.length }))
      $.each @collection.models, (index, item) =>
        view = new ProjectRowView(model: item)
        @$el.find('tbody').append(view.render().el)
      @

    on_new: (e) =>
      e.preventDefault()
      app.navigate 'project_new', trigger: true
