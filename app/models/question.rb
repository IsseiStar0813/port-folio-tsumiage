class Question < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  has_many :answers, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true

end
