class College < ApplicationRecord
  validates_presence_of :name

  has_many :exams

end
