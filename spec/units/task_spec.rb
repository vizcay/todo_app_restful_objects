require_relative '../spec_helper'

describe Task do
  subject(:task) { Task.new }

  it 'has an integer task_id with a value by default' do
    expect(task.task_id).to be_a Fixnum
  end

  it 'not allows to override id' do
    expect { task.task_id = 1 }.to raise_error
  end

  it 'has a description' do
    task.description = 'this is a description'
    expect(task.description).to eq 'this is a description'
  end

  it 'validates description is 50 chars max' do
    expect { task.description = 'x' * 51 }.to raise_error
  end

  it 'has a priority empty by default' do
    expect(task.priority).to be_nil
  end

  it 'validates priority in H, M, L' do
    expect do
      task.priority = 'L'
      task.priority = 'M'
      task.priority = 'H'
      task.priority = nil
    end.not_to raise_error

    expect { task.priority = 'X' }.to raise_error
  end

  it 'converts priority to priority_numeric' do
    task.priority = 'H'
    expect(task.priority_numeric).to eq 1
    task.priority = 'M'
    expect(task.priority_numeric).to eq 2
    task.priority = 'L'
    expect(task.priority_numeric).to eq 3
    task.priority = nil
    expect(task.priority_numeric).to eq 4
  end

  it 'has a project empty by default' do
    expect(task.project).to be_nil
  end

  it 'is uncompleted by default' do
    expect(task.completed).to eq false
  end

  it 'allows to be completed' do
    task.completed = true
    expect(task.completed).to eq true
  end

  it 'allows to set a due_by date' do
    task.due_by = Date.new(2014, 10, 5)
    expect(task.due_by).to eq Date.new(2014, 10, 5)
  end

  it 'has a default created_at date set to today' do
    expect(task.created_at).to eq Date.today
  end

  it 'not allows to set created_at' do
    expect { task.created_at = Date.new(2014, 10, 5) }.to raise_error
  end
end
