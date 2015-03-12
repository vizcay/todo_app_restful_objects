require_relative '../spec_helper.rb'

describe 'Tasks' do
  before do
    Application.instance.clear_tasks
    Application.instance.clear_projects
  end

  let(:task) do
    task             = Task.new
    task.description = 'do something'
    task.completed   = true
    task.due_by      = Date.new(2014, 10, 18)
    task
  end

  it 'gets a task representation' do
    get "/objects/Task/#{task.object_id}"
    expect(last_response.body).to match_json_expression({
      members: {
        task_id:     { value: task.task_id },
        description: { value: 'do something' },
        project:     { value: nil },
        completed:   { value: 'true' },
        total_cost:  { value: 0 },
        due_by:      { value: '2014-10-18' }
      }
    })
  end

  it 'creates a new task' do
    payload = {
      members: {
        description: { value: 'clean dust' },
        completed:   { value: 'true' },
        due_by:      { value: '2014-10-25' }
      }
    }

    post "/objects/Task", payload.to_json
    task = Application.instance.tasks.first
    expect(task.description).to eq 'clean dust'
    expect(task.completed).to   eq true
    expect(task.due_by).to      eq Date.new(2014, 10, 25)
  end

  it 'updates task' do
    task = Task.new
    payload = {
      description: { value: 'clean dust' },
      completed:   { value: 'true' },
      due_by:      { value: '2014-10-25' }
    }
    put "/objects/Task/#{task.rs_instance_id}", payload.to_json
    expect(task.description).to eq 'clean dust'
    expect(task.completed).to   eq true
    expect(task.due_by).to      eq Date.new(2014, 10, 25)
  end

  it 'deletes task' do
    task = Task.new
    delete "/objects/Task/#{task.rs_instance_id}"
    expect(task).to be_deleted
    expect(Application.instance.tasks).not_to include task
  end
end
