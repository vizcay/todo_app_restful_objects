$ =>
  class @Resources extends Backbone.Collection
    model: Resource

    toDestroy: []

    parse: (response) ->
      resources = []
      $(response.value).each (index, value) ->
        $.ajax value.href, async: false, success: (resource_response) ->
          resources.push(resource_response)
      resources

    save: (owner_task) =>
      $.each @models, (index, resource) ->
        resource.save() if resource.hasChanged()
        if resource.isNew()
          resource.save resource.attributes, success: =>
            payload = JSON.stringify({ value: { href: "#{resource.urlRoot}/#{resource.get('id')}" } })
            url = "#{appServer.get('currentServer')}/objects/Task/#{owner_task.get('id')}/collections/resources"
            $.ajax url, type: 'POST', async: false, data: payload, processData: false
      $.each @toDestroy, (i, resource) ->
        payload = JSON.stringify({ value: { href: "#{resource.urlRoot}/#{resource.get('id')}" } })
        url = "#{app.get('currentServer')}/objects/Task/#{owner_task.get('id')}/collections/resources"
        $.ajax url, type: 'DELETE', async: false, data: payload, processData: false, success: ->
          resource.destroy()
