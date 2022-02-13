class Answer < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :question
  validates :content, presence: true
end
