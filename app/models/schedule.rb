class Schedule < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :task, presence: true
  validates :total_hours, presence: true
  validates :total_minutes, presence: true
end
