class Task < ApplicationRecord
  validates :title, presence: { message: "cannot be blank" }
  validates :content, presence: { message: "cannot be blank" }
end
