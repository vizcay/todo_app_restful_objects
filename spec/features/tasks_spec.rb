require 'spec_helper'

feature 'Tasks', js: true do
  context 'when projects exists' do
    background do
      @project_1, @project_2, @project_3 = Project.new, Project.new, Project.new
      @project_1.description = 'project_1'
      @project_2.description = 'project_2'
      @project_3.description = 'project_3'
    end

    scenario 'it lists projects in select box' do
      visit '#task_new'
      expect(page).to have_css('select#project option', count: 4)
    end
  end
end

