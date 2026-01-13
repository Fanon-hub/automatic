require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:user) { create(:user, password: 'password', admin: true) }
  let!(:first_task) { create(:task, title: 'first_task', deadline_on: '2022-02-18', priority: 'medium', status: 'not_started', user: user) }
  let!(:second_task) { create(:task, title: 'second_task', deadline_on: '2022-02-17', priority: 'high', status: 'in_progress', user: user) }
  let!(:third_task) { create(:task, title: 'third_task', deadline_on: '2022-02-16', priority: 'low', status: 'completed', user: user) }

  before do
    @user = create(:user)
    login_as(user)
  end

  describe 'List display function' do
    before do
      visit tasks_path
    end

    describe 'Sort function' do
      context 'When clicking on the "Deadline" link' do
        it 'displays tasks sorted in ascending order by due date' do
          click_link 'Deadline'
          task_deadlines = all('tbody tr td:nth-child(2)').map(&:text)
          expect(task_deadlines).to eq ['2022-02-16', '2022-02-17', '2022-02-18']
        end
      end

      context 'When clicking on the "Priority" link' do
        it 'displays tasks sorted by priority (high → low)' do
          click_link 'Priority'
          task_priorities = all('tbody tr td:nth-child(3)').map(&:text)
          expect(task_priorities).to eq ['High', 'Medium', 'Low']
        end
      end
    end

    describe 'Search function' do
      context 'When searching by label' do
        it 'shows only tasks that have the selected label' do
          label = create(:label, user: user)
          task_with_label = create(:task, user: user, labels: [label])
          task_without = create(:task, user: user)
          visit tasks_path
          select label.name, from: 'search_label'
          click_button 'Search'
          expect(page).to have_content task_with_label.title
          expect(page).not_to have_content task_without.title
        end
      end

      context 'When searching by status' do
        it 'shows only tasks matching the selected status' do
          select 'In Progress', from: 'search_status'
          click_button 'Search'
          expect(page).to have_content 'second_task'
          expect(page).not_to have_content 'first_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'When searching by Title and status together' do
        it 'shows only tasks that match both the title keyword and status' do
          fill_in 'search_title', with: 'task'
          select 'Completed', from: 'Status'
          click_button 'Search'
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
      fill_in 'task_title', with: 'New Task'
      fill_in 'task_content', with: 'Some content'
      fill_in 'task_deadline_on', with: Date.current + 2.days
      select 'Medium', from: 'task_priority'
      select 'Not Started', from: 'task_status'
      click_button 'Create'
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content(/Task (?:was|has been) successfully created/)
      expect(page).to have_content 'New Task'
      # Verify the task belongs to the user
      expect(user.tasks.last.title).to eq 'New Task'
    end

    it 'shows validation errors on failed creation' do
      visit new_task_path
      fill_in 'task_title', with: ''
      fill_in 'task_deadline_on', with: ''
      click_button 'Create'
      expect(page).to have_content 'Title is required'
      expect(page).to have_content 'Deadline is required'
    end

    it 'successfully updates a task' do
      task = create(:task, title: 'Old Title', priority: :low, status: :not_started, user: user)
      visit edit_task_path(task)
      fill_in 'Title', with: 'Updated Title'
      select 'High', from: 'Priority'
      select 'In Progress', from: 'Status'
      click_button 'Update'
      expect(page).to have_current_path(tasks_path)
      expect(page).to have_content(/Task (?:was|has been) successfully updated/)
      expect(page).to have_content 'Updated Title'
      # Verify the task belongs to the user
      expect(user.tasks.find(task.id).title).to eq 'Updated Title'
    end

    it 'shows validation errors on failed update' do
      task = create(:task, title: 'To Edit', user: user)
      visit edit_task_path(task)
      fill_in 'Title', with: ''
      click_button 'Update'
      expect(page).to have_content 'Title is required'
    end
  end

  describe 'Pagination and filters' do
    before do
      create_list(:task, 25, :high_priority, :due_tomorrow, :in_progress, user: user)
    end

    it 'preserves sort and search parameters across pages' do
      visit tasks_path(sort_priority: true, search: { title: 'Task' })
      click_link 'Next' if page.has_link?('Next')
      expect(page).to have_current_path(/sort_priority=true/)
      expect(page).to have_content 'Task'
    end
  end
end