require 'rails_helper'

RSpec.describe TaskLabel, type: :model do
  describe 'associations' do
    it 'belongs to a task and a label' do
      task = create(:task)
      label = create(:label)
      tl = TaskLabel.create(task: task, label: label)

      expect(tl).to be_persisted
      expect(tl.task).to eq task
      expect(tl.label).to eq label
    end
  end
end
