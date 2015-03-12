$ =>
  class @ResourceRowView extends Backbone.View
    events:
      'click #remove':                'on_remove'
      'change #resource_description': 'on_description_change'
      'change #resource_cost':        'on_cost_change'

    tagName: 'tr'

    template:
      _.template $('#resource_row_template').html()

    render: =>
      @$el.html @template(@model.attributes)
      @

    on_remove: =>
      @model.collection.toDestroy.push @model unless @model.isNew()
      @model.collection.remove @model

    on_description_change: (event) =>
      @model.set {'description': $(event.target).val()}

    on_cost_change: (event) =>
      @model.set {'cost': $(event.target).val()}
