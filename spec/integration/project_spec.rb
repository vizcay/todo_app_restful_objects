require_relative '../spec_helper'

describe Project do
  context 'when a project is created' do
    let!(:project) { Project.new }

    let(:task_uncompleted) do
      task = Task.new
      task.completed = false
      task
    end

    let(:task_completed) do
      task = Task.new
      task.completed = true
      task
    end

    let(:task_completed_2) do
      task = Task.new
      task.completed = true
      task
    end

    it 'is added to the application projects' do
      expect(todo_app.projects).to include project
    end

    it 'computes #uncompleted_tasks' do
      expect { task_uncompleted.project = project }.to change { project.uncompleted_tasks }.from(0).to(1)
    end

    it 'computes #completed_tasks' do
      expect { task_completed.project = project }.to change { project.completed_tasks }.from(0).to(1)
    end

    it 'computes #total_tasks' do
      expect do
        task_completed.project = project
        task_uncompleted.project = project
      end.to change { project.total_tasks }.from(0).to(2)
    end

    it 'computes #completed_percentage' do
      task_uncompleted.project = project
      expect(project.completed_percentage).to eq 0
      task_completed.project = project
      expect(project.completed_percentage).to eq 50
      task_completed_2.project = project
      expect(project.completed_percentage).to eq 66.67
    end
  end
end
