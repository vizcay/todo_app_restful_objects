require 'restful_objects'
require_relative 'task'
require_relative 'project'
require_relative '../lib/fixtures.rb'

class Application
  include RestfulObjects::Service

  attr_reader :tasks, :projects

  action :get_all_tasks,    return_type: { list: Task }
  action :get_projects,     return_type: { list: Project }
  action :clear_tasks
  action :clear_projects
  action :fixtures_created, return_type: :bool
  action :create_fixtures

  def initialize
    super
    @@instance        = self
    @projects, @tasks = [], []
    @next_project_id  = @next_task_id = 0
  end

  def self.instance
    @@instance ||= Application.new
  end

  def next_task_id
    @next_task_id += 1
  end

  def next_project_id
    @next_project_id += 1
  end

  def clear_tasks
    @tasks.clear
  end

  def get_all_tasks
    @tasks
  end

  def get_uncompleted_tasks
    @tasks.select { |t| not t.completed }.sort { |t1, t2| t1.priority_numeric <=> t2.priority_numeric }
  end

  def get_completed_tasks
    @tasks.select { |t| t.completed }
  end

  def get_top_tasks
    get_completed_tasks.limit(10)
  end

  def get_projects
    @projects
  end

  def clear_projects
    @projects.clear
  end

  def reset
    clear_tasks
    clear_projects
  end

  def fixtures_created
    not @projects.empty? and not @tasks.empty?
  end

  def create_fixtures
    Fixtures.create
  end
end
