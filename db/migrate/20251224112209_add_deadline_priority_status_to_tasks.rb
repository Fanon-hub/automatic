class AddDeadlinePriorityStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline_on, :date, null: false
    add_column :tasks, :priority, :integer, null: false, default: 0
    add_column :tasks, :status, :integer, null: false, default: 0
    add_index :tasks, :status
  end
end
