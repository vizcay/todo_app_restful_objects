require 'spec_helper'

feature 'Projects,', js: true do
  scenario 'creates project' do
    visit '/'
    click_on 'Project'
    click_on 'New Project'
    fill_in 'project_description', with: 'Build house'
    click_on 'Create'
    expect(fragment(current_url)).to eq '#project_list'
    expect(page).to have_content 'Build house'
    expect(todo_app.get_projects.length).to            eq 1
    expect(todo_app.get_projects.first.description).to eq 'Build house'
  end

  scenario 'it deletes project' do
    project = Project.new
    project.description = 'Die young'
    visit "/#project_edit/#{project.__id__}"
    click_on 'Delete'
    expect(fragment(current_url)).to eq '#project_list'
    expect(page).not_to have_content 'Die young'
  end

  scenario 'it edits project' do
    project = Project.new
    project.description = 'save world'
    visit "/#project_edit/#{project.__id__}"
    fill_in 'project_description', with: 'save earth'
    click_on 'Save'
    expect(fragment(current_url)).to eq '#project_list'
    expect(page).not_to have_content 'save world'
    expect(page).to     have_content 'save earth'
  end

  scenario 'it lists projects' do
    project_1 = Project.new
    project_1.description = 'build keops'
    project_2 = Project.new
    project_2.description = 'build eiffel tower'
    project_3 = Project.new
    project_3.description = 'build pizza tower'
    visit '/#project_list'
    expect(page).to have_content 'build keops'
    expect(page).to have_content 'build eiffel tower'
    expect(page).to have_content 'build pizza tower'
  end
end

