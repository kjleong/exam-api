class ExamWindow < ApplicationRecord
  has_one :exam

  def within_window(start_time)
    start_time
  end

end
