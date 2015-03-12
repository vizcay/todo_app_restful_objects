$ =>
  class @Resource extends RestfulModel
    urlRoot: ->
      "#{appServer.get('currentServer')}/objects/Resource"

    defaults:
      description: ''
      cost:        0

    persistableAttributes: ['description', 'cost']
