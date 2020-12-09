class CreateExamWindows < ActiveRecord::Migration[6.0]
  def change
    create_table :exam_windows do |t|
      t.datetime :start
      t.datetime :end
      t.timestamps
    end
  end
end
