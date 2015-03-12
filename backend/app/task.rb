require 'date'
require 'restful_objects'
require_relative 'project'
require_relative 'resource'

class Task
  include RestfulObjects::Object

  property :task_id,      :int,    read_only: true
  property :description,  :string, max_length: 50
  property :project,      { object: Project }
  property :priority,     :string, max_length: 1, pattern: '(L|M|H)'
  property :completed,    :bool
  property :created_at,   :date,   read_only: true
  property :due_by,       :date
  property :total_cost,   :decimal

  collection :resources, Resource

  def initialize
    super
    @task_id    = Application.instance.next_task_id
    @completed  = false
    @created_at = Date.today
    Application.instance.tasks << self
  end

  def project_choices
    Application.instance.projects
  end

  def total_cost
    resources.inject { |r| r.cost } || BigDecimal(0)
  end

  def priority_numeric
    case @priority
      when 'H'
        1
      when 'M'
        2
      when 'L'
        3
      else
        4
    end
  end

  def on_after_delete
    Application.instance.tasks.delete(self)
  end
end
