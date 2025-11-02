require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation test' do
    context 'If the task Title is an empty string' do
      it 'Validation fails' do
        task = Task.create(title: '', content: 'Create a proposal.')
        expect(task).not_to be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'If the task content is empty' do
      it 'Validation fails' do
        task = Task.create(title: 'Test Title', content: '')
        expect(task).not_to be_valid
        expect(task.errors[:content]).to include("can't be blank")
      end
    end

    context 'If the task Title and content have values' do
      it 'You can register a task' do
        task = Task.create(title: 'Test Title', content: 'Test Content')
        expect(task).to be_valid
      end
    end
  end
end