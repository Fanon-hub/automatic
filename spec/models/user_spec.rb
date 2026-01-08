require 'rails_helper'

RSpec.describe 'User Model Functions', type: :model do
  describe 'Validation test' do
    context 'If the user name is an empty string' do
      it 'Validation fails' do
        user = User.new(name: '', email: 'test@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    
    context 'If the user email address is an empty string' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: '', password: 'password')
        expect(user).not_to be_valid
      end
    end
    
    context 'If the user password is an empty string' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: 'test@example.com', password: '')
        expect(user).not_to be_valid
      end
    end
    
    context 'If the user email address is already in use' do
      before { FactoryBot.create(:user, email: 'test@example.com') }
      
      it 'Validation fails' do
        user = User.new(name: 'Test', email: 'test@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
    
    context 'If the user password is less than 6 characters' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: 'test@example.com', password: '12345')
        expect(user).not_to be_valid
      end
    end
    
    context 'If the user name has a value, the email address is an unused value, and the password is at least 6 characters long' do
      it 'Validation Succeeds' do
        user = User.new(name: 'Test', email: 'unique@example.com', password: 'password')
        expect(user).to be_valid
      end
    end
  end
end