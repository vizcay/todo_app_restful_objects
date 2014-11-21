require 'spec_helper'

feature 'Projects,', js: true do
  it 'creates project' do
    visit '/'
    click_on 'Project'
    click_on 'New Project'
    fill_in 'project_description', with: 'Build house'
    click_on 'Create'
    expect(fragment(current_url)).to eq '#project_list'
    expect(page).to have_content 'Build house'
    expect(app.get_projects.length).to            eq 1
    expect(app.get_projects.first.description).to eq 'Build house'
  end

  it 'it deletes project' do
    project = Project.new
    project.description = 'Die young'
    visit "/#project_edit/#{project.__id__}"
    click_on 'Delete'
    expect(fragment(current_url)).to eq '#project_list'
    expect(page).not_to have_content 'Die young'
  end

  pending 'it edits project'

  it 'it lists projects' do
    project_1 = Project.new
    project_1.description = 'Build keops'
    visit '/#project_list'
    expect(page).to have_content 'Build keops'
  end
end

