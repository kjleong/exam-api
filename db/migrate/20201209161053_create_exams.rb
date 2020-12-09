class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.references :college
      t.references :exam_window
      t.string :name
      t.timestamps
    end
  end
end
