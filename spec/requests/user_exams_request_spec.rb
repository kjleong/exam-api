require 'rails_helper'

RSpec.describe "UserExams", type: :request do

  describe "request valid user to be assigned to exam" do
    it "should respond with 200" do
      params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 2,
        start_time: "2020-12-22 21:00:00",
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
