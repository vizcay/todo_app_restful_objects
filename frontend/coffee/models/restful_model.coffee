$ =>
  class @RestfulModel extends Backbone.Model
    parse: (response) =>
      properties = {}
      properties['id'] = response.instanceId
      $.each response.members, (property, member) =>
        if member.memberType == 'property'
          if member.value instanceof Object # detect property with values
            @["#{property}_choices"] = member.choices
            properties[property] = member.value.href
            properties["#{property}_title"] = member.value.title
          else
            properties[property] = member.value
      properties

    toJSON: =>
      representation = {}
      filtered = _.pick(@attributes, @persistableAttributes)
      $.each filtered, (name, value) ->
        if value? and typeof value is 'string' and value.match('^http://')
          representation[name] = { value: { href: value } }
        else
          representation[name] = { value: value }
      representation

    sync: (method, model, options) =>
      if method == 'create'
        options.attrs = { members: model.toJSON() }
      Backbone.sync(method, model, options)
