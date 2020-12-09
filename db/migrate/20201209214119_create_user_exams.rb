class CreateUserExams < ActiveRecord::Migration[6.0]
  def change
    create_table :user_exams do |t|
      t.references :user
      t.references :exam
      t.timestamps
    end
  end
end
