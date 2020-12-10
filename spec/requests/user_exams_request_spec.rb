require 'rails_helper'

RSpec.describe "UserExams", type: :request do

  before :each do
    @user = User.create(
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        )

    @college = College.create(name:"Pokemon Community College")

    @exam_window = ExamWindow.create(
        start: DateTime.new(2020,12,20,10,0,0),
        end: DateTime.new(2020,12,20,12,0,0)
    )

    @exam = Exam.create(
        name: "Fire Types - Mid Term 2",
        college_id: 1,
        exam_window_id: 1,
    )
  end

  describe "request valid user to be assigned to exam" do

    it "should respond with 200" do
      params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
      }

      post "/user_exams/new", params: params

      expect(response.code).to eq("200")
    end
  end

  describe "request invalid time for user exam assignment" do
    it "should respond with 400" do
      params = {
          first_name: "Ash",
          last_name: "Ketchum",
          phone_number: "5121231234",
          college_id: 1,
          exam_id: 2,
          start_time: "2020-12-22 21:00:00",
      }

      post "/user_exams/new", params: params

      expect(response.code).to eq("400")
    end
  end

end
