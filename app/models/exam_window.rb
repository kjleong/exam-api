class ExamWindow < ApplicationRecord
  validates :start, :end, presence: true
  has_one :exam



end
