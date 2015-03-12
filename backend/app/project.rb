# encoding: utf-8
require 'restful_objects'
require_relative 'task'

class Project
  include RestfulObjects::Object

  property :project_id,           :int,     read_only: true
  property :description,          :string,  max_length: 30
  property :image,                :blob
  property :completed_tasks,      :int,     read_only: true
  property :uncompleted_tasks,    :int,     read_only: true
  property :total_tasks,          :int,     read_only: true
  property :completed_percentage, :decimal, read_only: true
  property :created_at,           :date,    read_only: true

  def initialize
    super
    @project_id        = Application.instance.next_project_id
    @uncompleted_tasks = @total_tasks = @completed_percentage = 0
    @created_at        = Date.today
    Application.instance.projects << self
  end

  def description=(value)
    raise 'max length exceeded (30)' if value and value.length > 30
    @description = @title = value
  end

  def completed_tasks
    tasks.select { |t| t.completed }.size
  end

  def uncompleted_tasks
    tasks.select { |t| not t.completed }.size
  end

  def total_tasks
    tasks.size
  end

  def completed_percentage
    if total_tasks > 0
      (BigDecimal.new(total_tasks - uncompleted_tasks) / BigDecimal.new(total_tasks) * 100).round(2)
    else
      0
    end
  end

  private

  def tasks
    Application.instance.tasks.select { |t| t.project == self }
  end

  def on_after_delete
    Application.instance.projects.delete(self)
  end
end
