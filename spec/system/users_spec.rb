require 'rails_helper'

RSpec.describe 'User Management Functions', type: :system do
  let!(:user) { create(:user, password: 'password') }
  let!(:admin) { FactoryBot.create(:user, :admin, email: 'admin@example.com', password: 'password') }

  describe 'Registration function' do
    context 'When a user is registered' do
      it 'Transitions to the task list screen' do
        visit new_user_path
        fill_in 'Name',               with: 'New User'
        fill_in 'Email address',       with: 'new@example.com'
        fill_in 'Password',           with: 'password'
        fill_in 'Password (confirmation)',   with: 'password'
        click_button 'Sign up'

        expect(page).to have_content('You are registered.')
        expect(page).to have_current_path(tasks_path)
      end
    end

    context 'When moving to the Task List screen without logging in' do
      it 'Redirects to the login screen and displays "Please log in"' do
        visit tasks_path
        expect(page).to have_content('Please log in.')
        expect(page).to have_current_path(login_path)  # or new_session_path
      end
    end
  end

  describe 'Login function' do
    context 'When logged in as a registered user' do
      it 'Moves to the Task List screen and displays "You are logged in."' do
        login_as(user)
        expect(page).to have_content('You are logged in.')
        expect(page).to have_current_path(tasks_path)
      end
    end
  end

  describe 'Administrator function' do
    context 'When the administrator logs in' do
      it 'Can access the user list screen' do
        login_as(admin)
        visit admin_users_path
        expect(page).to have_content('User list page')
      end
    end

    context 'When a general user tries to access the User List screen' do
      it 'Redirects to task list and shows error message' do
        login_as(user)
        visit admin_users_path
        expect(page).to have_content('You are not authorized.')
        expect(page).to have_current_path(tasks_path)
      end
    end
  end
end