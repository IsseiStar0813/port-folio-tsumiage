class Schedule < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :task, presence: true
end
