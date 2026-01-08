require 'rails_helper'

RSpec.describe 'User Management Functions', type: :system do
  let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:user, :admin) }
  
  describe 'Registration function' do
    context 'When a user is registered' do
      it 'Transition to the task list screen' do
        visit new_user_path
        fill_in '名前', with: 'New User'
        fill_in 'メールアドレス', with: 'new@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認）', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'アカウントを登録しました'
        expect(page).to have_current_path(tasks_path)
      end
    end
    
    context 'When you move to the Task List screen without logging in' do
      it 'The user is redirected to the login screen and the message "Please log in" is displayed.' do
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path(new_session_path)
      end
    end
  end
  
  describe 'Login function' do
    context 'When logged in as a registered user' do
      it 'Moves to the Task List screen and displays the message "You are logged in."' do
        visit new_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_current_path(tasks_path)
      end
    end
  end
  
  describe 'Administrator function' do
    context 'When the administrator logs in' do
      it 'Access to the user list screen' do
        login_as(admin)
        visit admin_users_path
        expect(page).to have_content 'ユーザー一覧ページ'
      end
    end
    
    context 'When a general user accesses the User List screen' do
      it 'Moves to the task list screen and displays the error message' do
        login_as(user)
        visit admin_users_path
        expect(page).to have_content '管理者のみアクセスできます'
        expect(page).to have_current_path(tasks_path)
      end
    end
  end
end 