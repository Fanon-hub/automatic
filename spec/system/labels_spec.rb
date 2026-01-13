require 'rails_helper'

RSpec.describe 'Label management function', type: :system do
  let!(:user) { create(:user, password: 'password', admin: true) }

  before do
    login_as(user)
  end

  describe 'Registration function' do
    context 'When a label is registered' do
      it 'Registered labels are displayed.' do
        visit new_label_path
        fill_in 'label_name', with: 'Test Label', visible: :all 
        click_button 'register'
        expect(page).to have_content 'Label has been created.'
        expect(page).to have_content 'Test Label'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of registered labels is displayed.' do
        create(:label, name: 'Work', user: user)
        create(:label, name: 'Personal', user: user)
        visit labels_path
        expect(page).to have_content 'Work'
        expect(page).to have_content 'Personal'
      end
    end
  end
end