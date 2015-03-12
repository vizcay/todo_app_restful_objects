$ =>
  class @ResourcesTableView extends Backbone.View
    initialize: =>
      super
      @collection.on 'sync',   => @render()
      @collection.on 'add',    => @render()
      @collection.on 'remove', => @render()

    events:
      'click #append': 'on_append'

    template:
      _.template $('#resources_table_template').html()

    render: =>
      @$el.html(@template())
      $.each @collection.models, (index, resource) =>
        view = new ResourceRowView(model: resource)
        @$el.find('tbody').append(view.render().el)
      @

    on_append: =>
      @collection.add new Resource
