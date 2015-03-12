$ =>
  class @Tasks extends Backbone.Collection
    url: ->
      "#{appServer.get('currentServer')}/services/Application/actions/get_all_tasks/invoke"

    model: Task

    parse: (response) ->
      tasks = []
      $(response.result.value).each (index, value) ->
        $.ajax value.href, async: false, success: (task_response) ->
          tasks.push(task_response)
      tasks

    delete_all: =>
      $.ajax
        url: "#{appServer.get('currentServer')}/services/Application/actions/clear_tasks/invoke"
        success: ->
          app.navigate 'tasks_list', trigger: true
