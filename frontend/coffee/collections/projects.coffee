$ =>
  class @Projects extends Backbone.Collection
    url: ->
      "#{appServer.get('currentServer')}/services/Application/actions/get_projects/invoke"

    model: Project

    parse: (response) ->
      projects = []
      $(response.result.value).each (index, value) ->
        $.ajax value.href, async: false, success: (project_response) ->
          projects.push(project_response)
      projects

    delete_all: =>
      $.ajax
        url: "#{appServer.get('currentServer')}/services/Application/actions/clear_projects/invoke"
        success: ->
          app.navigate 'project_list', trigger: true
