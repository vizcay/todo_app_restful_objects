$ =>
  class @HomeView extends Backbone.View
    initialize: ->
      appServer.on('change', @render, @)
      appServer.try_to_connect appServer.get('currentServer'), success: @on_connected_succesfully

    events:
      'click #connect':         'on_connect'
      'click #create_fixtures': 'on_create_fixtures'

    template: _.template $('#home_template').html()

    render: =>
      @$el.html @template(appServer.attributes)
      @

    on_connect: =>
      appServer.try_to_connect @$('#current_server').val(),
        success: @on_connected_succesfully
        error: =>
          $('#modal-ajax-wait').modal('hide')
          alert 'Unable to connect to server.'
          @render()

    on_connected_succesfully: =>
      $('#modal-ajax-wait').modal('hide')
      unless appServer.fixtures_created()
        appServer.create_fixtures() if confirm('Connected to server, create fixtures?')

    on_create_fixtures: =>
      app.navigate 'create_fixtures', trigger: true

