$ =>
  class @DashboardView extends Backbone.View
    template:
      _.template $('#dashboard_template').html()

    project_template:
      _.template $('#dashboard_project_template').html()

    task_template:
      _.template $('#dashboard_project_task_template').html()

    render: =>
      @$el.html @template()
      $.each @collection.models, (index, project) =>
        column = if index % 2 == 0 then @$el.find('#left_column') else @$el.find('#right_column')
        column.append @project_template(project.attributes)
        $.each project.tasks, (index2, task) =>
          column.find('.project_box').last().find('.tasks_container').append @task_template(task.attributes)
        if project.attributes.image
          column.find('.project_image').last().attr 'src', 'data:image/png;base64,' + project.attributes.image
      @
