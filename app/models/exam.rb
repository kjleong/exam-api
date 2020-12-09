class Exam < ApplicationRecord
  belongs_to :college
  belongs_to :user_exam

  def belongs_to_college(college)
    self.college == college
  end

end
