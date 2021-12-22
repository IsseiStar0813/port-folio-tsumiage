class Schedule < ApplicationRecord

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :task, presence: true
end
