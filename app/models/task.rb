class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  before_validation :set_default_deadline_on, on: :create

  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  # Scopes for sorting
  scope :latest, -> { order(created_at: :desc) }
  scope :deadline_asc, -> { order(deadline_on: :asc) }
  scope :priority_desc, -> { order(priority: :desc) }

  # Scopes for searching
  scope :search_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :search_status, ->(status) { where(status: status) }
  scope :search_priority, ->(priority) { where(priority: priority) }

  def self.search(params)
    tasks = all
    tasks = tasks.search_title(params[:title]) if params[:title].present?
    tasks = tasks.search_status(params[:status]) if params[:status].present?
    tasks = tasks.search_priority(params[:priority]) if params[:priority].present?
    tasks
  end

  private

  def set_default_deadline_on
    self.deadline_on ||= Date.current
  end
end