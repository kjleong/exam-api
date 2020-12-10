class UserExam < ApplicationRecord
  validates :exam_id, :user_id, presence: true
  has_many :exams
  has_many :users
end
