class AddUserToLabels < ActiveRecord::Migration[7.2]
  def change
    add_reference :labels, :user, null: false, foreign_key: true
  end
end
