class Issue < ApplicationRecord
  belongs_to :project

  STATUS_OPTIONS = %w[New In_Progress Closed].freeze
  PRIORITY_OPTIONS = (1..5).to_a.freeze

  validates :title, presence: true, length: { maximum: 100 }
  validates :status, presence: true, inclusion: { in: STATUS_OPTIONS }
  validates :priority, presence: true, inclusion: { in: PRIORITY_OPTIONS }

  scope :by_status, ->(status) { where(status: status) }
  scope :by_priority, ->(priority) { where(priority: priority) }
  scope :recent, -> { order(created_at: :desc) }
end
