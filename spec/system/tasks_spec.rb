require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:first_task) { create(:task, title: 'first_task', deadline_on: '2022-02-18', priority: 'medium', status: 'not_started', user: user) }
  let!(:second_task) { create(:task, title: 'second_task', deadline_on: '2022-02-17', priority: 'high', status: 'in_progress', user: user) }
  let!(:third_task) { create(:task, title: 'third_task', deadline_on: '2022-02-16', priority: 'low', status: 'completed', user: user) }
  
  before do
    login(user)
  end

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

  describe 'Create and update flows' do
    it 'successfully creates a new task with all fields' do
      visit new_task_path
      fill_in 'タイトル', with: 'New Task'
      fill_in '内容', with: 'Some content'
      fill_in '終了期限', with: Date.current + 2.days
      select '中', from: '優先度'
      select '未着手', from: 'ステータス'
      click_button '登録'
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content('タスクが登録されました').or have_content('タスクを登録しました')
      expect(page).to have_content('New Task')
      # Verify the task belongs to the user
      expect(user.tasks.last.title).to eq('New Task')
    end

    it 'shows validation errors on failed creation' do
      visit new_task_path
      fill_in 'タイトル', with: ''
      fill_in '終了期限', with: ''
      click_button '登録'
      expect(page).to have_content('タイトルを入力してください')
      expect(page).to have_content('終了期限を入力してください').or have_content('Deadline onを入力してください')
    end

    it 'successfully updates a task' do
      task = create(:task, title: 'Old Title', priority: :low, status: :not_started, user: user)
      visit edit_task_path(task)
      fill_in 'タイトル', with: 'Updated Title'
      select '高', from: '優先度'
      select '着手中', from: 'ステータス'
      click_button '更新'
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content('タスクが更新されました').or have_content('タスクを更新しました')
      expect(page).to have_content('Updated Title')
      # Verify the task belongs to the user
      expect(user.tasks.find(task.id).title).to eq('Updated Title')
    end

    it 'shows validation errors on failed update' do
      task = create(:task, title: 'To Edit', user: user)
      visit edit_task_path(task)
      fill_in 'タイトル', with: ''
      click_button '更新'
      expect(page).to have_content('タイトルを入力してください')
    end
  end

  describe 'Pagination and filters' do
    before do
      create_list(:task, 25, :high_priority, :due_tomorrow, :in_progress, user: user)
    end
    
    it 'preserves sort/search params across pages' do
      visit tasks_path(sort_priority: true, search: { title: 'Task' })
      click_link '次へ' if page.has_link?('次へ')
      expect(page).to have_current_path(/sort_priority=true/)
      expect(page).to have_content('Task')
    end
  end
end