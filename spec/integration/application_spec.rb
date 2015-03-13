require_relative '../spec_helper'

describe Application do
  subject!(:application) { Application.new }

  context 'when a task is created' do
    let!(:task) { Task.new }

    it 'is returned by #get_all_tasks' do
      expect(Application.instance.get_all_tasks).to include task
    end

    it 'is returned by #get_uncompleted_tasks' do
      expect(application.get_uncompleted_tasks).to include task
    end
  end

  context 'when a project is created' do
    let!(:project) { Project.new }

    it 'is returned by #get_projects' do
      expect(application.get_projects).to include project
    end
  end

  context 'when a task is marked as completed' do
    let!(:completed_task) do
      task = Task.new
      task.completed = true;
      task
    end

    it 'is returned by #get_completed_tasks' do
      expect(application.get_completed_tasks).to include completed_task
    end
  end

  it '#clear_tasks' do
    Task.new
    application.clear_tasks
    expect(application.tasks).to be_empty
  end

  it '#clear_projects' do
    Project.new
    application.clear_projects
    expect(application.projects).to be_empty
  end
end
