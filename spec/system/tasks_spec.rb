require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:first_task) { create(:task, title: 'first_task', deadline_on: '2022-02-18', priority: 'medium', status: 'not_started') }
  let!(:second_task) { create(:task, title: 'second_task', deadline_on: '2022-02-17', priority: 'high', status: 'in_progress') }
  let!(:third_task) { create(:task, title: 'third_task', deadline_on: '2022-02-16', priority: 'low', status: 'completed') }

  describe 'List display function' do
    before do
      visit tasks_path
    end

    describe 'Sort function' do
      context 'When clicking on "終了期限" link' do
        it 'displays a list of tasks sorted in ascending order of due date' do
          click_link '終了期限'
          task_deadlines = all('tbody tr td:nth-child(2)').map(&:text)
          expect(task_deadlines).to eq ['2022-02-16', '2022-02-17', '2022-02-18']
        end
      end

      context 'When clicking on "優先度" link' do
        it 'displays a list of tasks sorted by priority' do
          click_link '優先度'
          task_priorities = all('tbody tr td:nth-child(3)').map(&:text)
          expect(task_priorities).to eq ['高', '中', '低']
        end
      end
    end

    describe 'Search function' do
      context 'When doing fuzzy search by Title' do
        it 'displays only tasks containing the search word' do
          fill_in 'タイトル', with: 'first'
          click_button '検索'
          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'When searching by status' do
        it 'displays only tasks matching the searched status' do
          select '着手中', from: 'ステータス'
          click_button '検索'
          expect(page).to have_content 'second_task'
          expect(page).not_to have_content 'first_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'When searching by Title and status' do
        it 'displays only tasks that contain the search word in Title and match the status' do
          fill_in 'タイトル', with: 'task'
          select '完了', from: 'ステータス'
          click_button '検索'
          expect(page).to have_content 'third_task'
          expect(page).not_to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
        end
      end
    end
  end
end