$ =>
  class @Application extends Backbone.Router
    routes:
      '':                    'home'
      'dashboard':           'dashboard'
      'create_fixtures':     'create_fixtures'
      'task_new':            'task_new'
      'tasks_list':          'tasks_list'
      'task_view/:id':       'task_view'
      'tasks_delete_all':    'tasks_delete_all'
      'project_new':         'project_new'
      'project_edit/:id':    'project_edit'
      'project_list':        'project_list'
      'projects_delete_all': 'projects_delete_all'

    home: ->
      new HomeView(el: $('#content'), model: appServer).render()

    dashboard: ->
      projects = new Projects
      projects.fetch
        success: ->
          tasks = new Tasks
          tasks.fetch
            success: ->
              $.each projects.models, (index, project) ->
                project.tasks = _.filter tasks.models, (task) ->
                  task.get('project_title') == project.get('description')
              dashboardView = new DashboardView(collection: projects, el: $('#content'))
              dashboardView.render()

    create_fixtures: =>
      appServer.create_fixtures()

    tasks_list: ->
      @tasks = new Tasks
      @view  = new TasksTableView(collection: @tasks)
      @tasks.fetch
        success: =>
          $('#content').empty().append(@view.render().el)

    task_new: =>
      @taskFormView = new TaskFormView(model: new Task)
      $('#content').empty().append(@taskFormView.render().el)

    task_view: (id) ->
      task = new Task(id: id)
      task.fetch
        success: =>
          @view = new TaskFormView(model: task)
          $('#content').empty().append(@view.render().el)
      @task = task

    tasks_delete_all: ->
      $('#content').empty()
      @tasks = new Tasks
      @tasks.delete_all()

    project_new: ->
      @projectFormView = new ProjectFormView(model: new Project)
      $('#content').empty().append(@projectFormView.render().el)

    project_edit: (id) ->
      project = new Project(id: id)
      project.fetch
        success: =>
          @view = new ProjectFormView(model: project)
          $('#content').empty().append(@view.render().el)

    project_list: ->
      @projects          = new Projects
      @projectsTableView = new ProjectsTableView(collection: @projects)
      @projects.fetch
        success: =>
          $('#content').empty().append(@projectsTableView.render().el)

    projects_delete_all: ->
      $('#content').empty()
      @projects = new Projects
      @projects.delete_all()

    logs: []

  $('#view_log').on 'click', (event) ->
    event.preventDefault()
    $('#modal_view_log').modal('show')
    text_log = ''
    $.each app.logs, (index, log) ->
      json = if log.data then JSON.stringify(JSON.parse(log.data), null, 2) else ''
      if log.type == 'request'
        text_log += ">>> #{log.method} #{log.url}\n#{json}\n"
      else
        text_log += "#{json}\n\n"
    $('#modal_view_log #log').val text_log

  @app       = new Application
  @appServer = new ApplicationServer
  Backbone.history.start()
