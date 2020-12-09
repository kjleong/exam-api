# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
user_data = [
    {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234"
    },
    {
        first_name: "Gary",
        last_name: "Oak",
        phone_number: "5123214321"
    },
    {
        first_name: "Alexander",
        last_name: "Hamilton",
        phone_number: "5122342345"
    },
    {
        first_name: "Aaron",
        last_name: "Burr",
        phone_number: "5124325432"
    },
    {
        first_name: "George",
        last_name: "Washington",
        phone_number: "5126547654"
    }
]
user_data.each do |user|
  User.create(
      first_name: user[:first_name],
      last_name: user[:last_name],
      phone_number: user[:phone_number],
  )
end

# Colleges
college_data = [
    {
        name: "Pokemon Community College"
    },
    {
        name: "Mushroom Kingdom University"
    },
    {
        name: "Hyrule College of Medicine"
    },
]
college_data.each do |college|
  College.create(
    name: college[:name]
  )
end

# Exam Window
exam_window_data = [
    {
        start: DateTime.new(2020,12,20,10,0,0,"-6:00"),
        end: DateTime.new(2020,12,20,12,0,0,"-6:00"),
    },
    {
        start: DateTime.new(2020,12,22,14,0,0,"-6:00"),
        end: DateTime.new(2020,12,22,16,0,0,"-6:00"),
    },
    {
        start: DateTime.new(2020,12,24,12,0,0,"-6:00"),
        end: DateTime.new(2020,12,24,13,0,0,"-6:00"),
    },
]
exam_window_data.each do |ew|
  ExamWindow.create(
      start: ew[:start],
      end: ew[:end]
  )
end

# Exams
exam_data = [
    {
        name: "Science - Mid Term 1",
        college: College.find_by_name("Hyrule College of Medicine"),
        user: User.find_by(first_name:"Ash",last_name:"Ketchum"),
        exam_window_id: 1,
    },
    {
        name: "Fire Types - Mid Term 2",
        college: College.find_by_name("Pokemon Community College"),
        user: User.find_by(first_name:"Gary",last_name:"Oak"),
        exam_window_id: 2,
    },
    {
        name: "Bosses - Final",
        college: College.find_by_name("Mushroom Kingdom University"),
        user: User.find_by(first_name:"Alexander",last_name:"Hamilton"),
        exam_window_id: 3,
    }
]
exam_data.each do |exam|
  e = Exam.new
  e.name = exam[:name]
  e.user_id = exam[:user].id
  e.college_id = exam[:college].id
  e.exam_window_id = exam[:exam_window_id]
  e.save!
end

