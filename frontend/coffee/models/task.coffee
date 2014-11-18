$ =>
  class @Task extends RestfulModel
    initialize: =>
      @resources     = new Resources
      @resources.url = "#{appServer.get('currentServer')}/objects/Task/#{@get('id')}/collections/resources"
      @resources.fetch()

    urlRoot: ->
      "#{appServer.get('currentServer')}/objects/Task"

    defaults:
      task_id:      null
      description:  ''
      project:      null
      completed:    false
      total_cost:   0
      due_by:       new Date().toJSON().slice(0,10)
      created_at:   null

    persistableAttributes: ['description', 'project', 'completed', 'due_by', 'priority', 'completed']

    sync: (method, model, options) =>
      super
      if method == 'update'
        @resources.save @

