require_relative '../spec_helper'

describe Task do
  context 'when a task is created' do
    let!(:task) { Task.new }

    it 'is added to the application tasks' do
      expect(Application.instance.tasks).to include task
    end
  end
end
