class Project < ApplicationRecord
  has_many :issues, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
end
