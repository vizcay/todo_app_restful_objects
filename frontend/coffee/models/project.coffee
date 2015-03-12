$ =>
  class @Project extends RestfulModel
    urlRoot: ->
      "#{appServer.get('currentServer')}/objects/Project"

    defaults:
      project_id:           null
      description:          ''
      uncompleted_tasks:    0
      total_tasks:          0
      completed_percentage: 0

    persistableAttributes: ['description', 'image']
