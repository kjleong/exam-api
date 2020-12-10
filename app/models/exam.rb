class Exam < ApplicationRecord
  validates_presence_of :name

  belongs_to :college

  def belongs_to_college(college)
    self.college.id == college.id
  end

  def within_time_window(start_time)
    ew = ExamWindow.find_by_id(self.exam_window_id)
    dt = DateTime.strptime(start_time, '%Y-%m-%d %H:%M:%S') rescue false
    if dt == false
      return false
    end
    if ew && dt.between?(ew.start,ew.end)
      return true
    end
    false
  end

end
