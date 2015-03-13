require_relative '../spec_helper'

describe Project do
  subject(:project) { Project.new }

  it 'has a description' do
    project.description = 'new project'
    expect(project.description).to eq 'new project'
  end

  it 'validates description is 30 chars max' do
    expect { project.description = 'x' * 31 }.to raise_error
  end

  it 'has a #created_at date' do
    expect(project.created_at).to eq Date.today
  end

  it 'not allows to set #created_at' do
    expect { project.created_at = Date.new }.to raise_error
  end
end
