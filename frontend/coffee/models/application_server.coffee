$ =>
  class @ApplicationServer extends Backbone.Model
    initialize: ->
      if localStorage.getItem("currentServer")?
        @set "currentServer", localStorage.getItem("currentServer")
      else
        @set "currentServer", "#{location.protocol}//#{location.hostname}#{if location.port then ':' + location.port else ''}/restful_objects"

    defaults:
      connected: false

    try_to_connect: (server, options) =>
      $.ajax "#{server}/services/Application",
        success: =>
          @set 'currentServer', server
          @set 'connected', true
          localStorage.setItem("currentServer", server)
          options?.success?()
        error: =>
          options?.error?()

    create_fixtures: =>
      $.ajax
        url: "#{@get('currentServer')}/services/Application/actions/create_fixtures/invoke"
        success: ->
          app.navigate 'dashboard', trigger: true

    fixtures_created: =>
      result = false
      $.ajax "#{@get('currentServer')}/services/Application/actions/fixtures_created/invoke",
        async: false
        success: (data) =>
          result = JSON.parse(data).result.value == 'true'
      return result
