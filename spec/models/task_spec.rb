require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validations' do
    context 'If the task Title is an empty string' do
      it 'is not valid' do
        task = Task.create(title: '', content: 'Create task content.')
        expect(task).not_to be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'If the task Content is an empty string' do
      it 'is not valid' do
        task = Task.create(title: 'Task Title', content: '')
        expect(task).not_to be_valid
        expect(task.errors[:content]).to include("can't be blank")
      end
    end
    context 'If both the task Title and Content are provided' do
      it 'is valid' do
        task = Task.create(title: 'Task Title', content: 'Create task content.')
        expect(task).to be_valid
      end
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
