class Schedule < ApplicationRecord

  belongs_to :user
  validates :user_id, presence: true
  validates :task, presence: true
  validates :start, presence: true
  validates :finish, presence: true
  validates :total_hours, presence: true
  validates :total_minutes, presence: true
  validate :start_finish_check

  def start_finish_check
    if start && finish
      errors.add(:finish, "は開始時刻より遅い時間を選択してください") if self.start > self.finish
    end
  end

end
