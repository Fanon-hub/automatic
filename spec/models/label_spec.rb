require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'Validation test' do
    let(:user) { create(:user) }

    context 'If the label name is an empty string' do
      it 'Validation fails' do
        label = user.labels.build(name: '')
        expect(label).not_to be_valid
        expect(label.errors[:name]).to include('Please enter a name')
      end
    end

    context 'If the label name has a value' do
      it 'Validation Succeeds' do
        label = user.labels.build(name: 'Test')
        expect(label).to be_valid
      end
    end
  end
end