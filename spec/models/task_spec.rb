require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation' do
    it 'is valid with title, deadline_on, priority and status' do
      task = build(:task)
      expect(task).to be_valid
    end

    it 'is invalid without title' do
      task = build(:task, title: nil)
      expect(task).to be_invalid
    end

    it 'is invalid without deadline_on' do
      task = build(:task, deadline_on: nil)
      expect(task).to be_invalid
    end

    it 'is invalid without priority' do
      task = build(:task, priority: nil)
      expect(task).to be_invalid
    end

    it 'is invalid without status' do
      task = build(:task, status: nil)
      expect(task).to be_invalid
    end
  end

  describe 'Search function' do
    let!(:first_task) { create(:task, title: 'first_task', deadline_on: '2022-02-18', priority: 'medium', status: 'not_started') }
    let!(:second_task) { create(:task, title: 'second_task', deadline_on: '2022-02-17', priority: 'high', status: 'in_progress') }
    let!(:third_task) { create(:task, title: 'third_task', deadline_on: '2022-02-16', priority: 'low', status: 'completed') }

    context 'When searching by title with scope method' do
      it 'narrows down tasks containing search words' do
        expect(Task.search_title('first')).to include(first_task)
        expect(Task.search_title('first')).not_to include(second_task)
        expect(Task.search_title('first')).not_to include(third_task)
        expect(Task.search_title('first').count).to eq 1
      end
    end

    context 'When searching by status with scope method' do
      it 'narrows down tasks that exactly match the status' do
        expect(Task.search_status('not_started')).to include(first_task)
        expect(Task.search_status('not_started')).not_to include(second_task)
        expect(Task.search_status('not_started')).not_to include(third_task)
        expect(Task.search_status('not_started').count).to eq 1
      end
    end

    context 'When performing fuzzy search by title and status search' do
      it 'narrows down tasks that contain the search word in title and exactly match the status' do
        tasks = Task.search_title('task').search_status('in_progress')
        expect(tasks).to include(second_task)
        expect(tasks).not_to include(first_task)
        expect(tasks).not_to include(third_task)
        expect(tasks.count).to eq 1
      end
    end
  end

  describe 'Sort function' do
    let!(:task1) { create(:task, deadline_on: '2022-02-18', priority: 'medium') }
    let!(:task2) { create(:task, deadline_on: '2022-02-17', priority: 'high') }
    let!(:task3) { create(:task, deadline_on: '2022-02-16', priority: 'low') }

    it 'sorts by deadline in ascending order' do
      tasks = Task.deadline_asc
      expect(tasks.first).to eq task3
      expect(tasks.second).to eq task2
      expect(tasks.third).to eq task1
    end

    it 'sorts by priority in descending order' do
      tasks = Task.priority_desc
      expect(tasks.first).to eq task2
      expect(tasks.second).to eq task1
      expect(tasks.third).to eq task3
    end
  end
end