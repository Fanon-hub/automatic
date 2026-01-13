class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  # `set_default_deadline_on` left defined for test stubbing but not run automatically

  enum :priority, %i[low medium high]
  enum :status,   %i[not_started in_progress completed]

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
    self.deadline_on = Date.current if deadline_on.nil?
  end
end