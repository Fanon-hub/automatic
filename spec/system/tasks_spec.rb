require 'rails_helper'

RSpec.describe 'Task management function', type: :system do
  describe 'Registration function' do
    context 'When registering a task' do
      it 'The registered task is displayed' do
        visit new_task_path
        fill_in 'Title Title', with: 'Test Title'
        fill_in 'Content', with: 'Test Content'
        click_button 'Create Task'
        expect(page).to have_content 'Test Title'  # Task in list
        expect(page).to have_content 'Task was successfully created.'  # Flash
        expect(page).to have_current_path tasks_path  # Redirect to index
      end
    end

    context 'When validation fails during registration' do
      it 'Displays title error if title empty (content filled)' do
        visit new_task_path
        fill_in 'Title Title', with: ''  # Explicitly blank
        fill_in 'Content', with: 'Valid content'
        click_button 'Create Task'
        expect(page).to have_content "Title can't be blank"
        expect(page).not_to have_content "Content can't be blank"
        expect(page).to have_current_path new_task_path  # Stays on new
      end

      it 'Displays content error if content empty (title filled)' do
        visit new_task_path
        fill_in 'Title Title', with: 'Valid title'
        fill_in 'Content', with: ''  # Explicitly blank
        click_button 'Create Task'
        expect(page).to have_content "Content can't be blank"
        expect(page).not_to have_content "Title can't be blank"
        expect(page).to have_current_path new_task_path
      end

      it 'Displays both errors if title and content empty' do
        visit new_task_path
        fill_in 'Title Title', with: ''  # Explicitly blank
        fill_in 'Content', with: ''  # Explicitly blank
        click_button 'Create Task'
        expect(page).to have_content "Title can't be blank"
        expect(page).to have_content "Content can't be blank"
        expect(page).to have_current_path new_task_path
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of registered tasks is displayed' do
        task = FactoryBot.create(:task)
        second_task = FactoryBot.create(:second_task)
        visit tasks_path
        expect(page).to have_content task.title
        expect(page).to have_content second_task.title
      end
    end
  end

  describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the task is displayed' do
        task = FactoryBot.create(:task)
        visit task_path(task)
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(page).to have_content task.created_at.strftime('%Y-%m-%d %H:%M:%S UTC')
      end
    end
  end
end