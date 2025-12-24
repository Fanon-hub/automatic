require 'rails_helper'

RSpec.describe 'List display function', type: :system do
  let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: Time.zone.parse('2022-02-16')) }
  let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: Time.zone.parse('2022-02-17')) }
  let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: Time.zone.parse('2022-02-18')) }

  before do
    visit tasks_path
  end

  context 'When transitioning to the list screen' do
    it 'The list of created tasks is displayed in descending order of creation date and time.' do
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content('first_task')   # Newest first
      expect(task_list[1]).to have_content('second_task')
      expect(task_list[2]).to have_content('third_task')   # Oldest last
    end
  end

    context 'Task creation' do
    it 'Shows Japanese success flash and redirects to show' do
      visit new_task_path
      fill_in 'task_title', with: 'Test'
      fill_in 'task_content', with: 'Content'
      click_button '登録'
      expect(page).to have_content('タスクを登録しました')
      expect(page).to have_current_path(task_path(Task.last))
    end
  end
end