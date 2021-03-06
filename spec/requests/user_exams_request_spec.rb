require 'rails_helper'

RSpec.describe "UserExams", type: :request do

  before :each do
    @user = User.create(
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        )

    @college = College.create(name:"Pokemon Community College")
    @college2 = College.create(name:"Hyrule College of Medicine")

    @exam_window = ExamWindow.create(
        start: DateTime.new(2020,12,20,10,0,0),
        end: DateTime.new(2020,12,20,12,0,0)
    )

    @exam = Exam.create(
        name: "Fire Types - Mid Term 2",
        college_id: 1,
        exam_window_id: 1,
    )

    @exam2 = Exam.create(
        name: "Potions - Mid Term 2",
        college_id: 2,
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
      expect(response.status).to eq(200)
    end
  end

  describe "request new user to be assigned to exam" do
    params = {
        first_name: "Gary",
        last_name: "Oak",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
    }
    it "should start with 1 user" do
      expect(User.all.count).to eq(1)
    end
    it "should create new user" do
      post "/user_exams/new", params: params
      expect(User.all.count).to eq(2)
    end
    it "should have status 200" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(200)
    end
  end

  describe "request invalid time for user exam assignment" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 13:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should have the start_time error message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("start_time #{params[:start_time]} is outside the time window for the exam")
    end
  end

  describe "request invalid college" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 3,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should have the invalid college message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("college_id #{params[:college_id]} not found in database")
    end
  end

  describe "request invalid exam" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 3,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should have the invalid exam message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("exam_id #{params[:exam_id]} not found in database")
    end
  end

  describe "request exam on college" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 2,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should have the invalid exam-college message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("exam_id #{params[:exam_id]} doesn't belong to college_id #{params[:college_id]}")
    end
  end

  describe "request repeated user exam assignment" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should have the invalid exam-college message" do
      post "/user_exams/new", params: params
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("User 1 already assigned to specified exam #{params[:exam_id]}")
    end
  end

  describe "request with invalid name" do
    params = {
        first_name: ["Ash"],
        last_name: "Ketchum",
        phone_number: "5121231234",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should give name validation message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("#{params[:first_name]} must be a string")
    end
  end

  describe "request with invalid name" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "512123123",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00:00",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should give phone number validation message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("#{params[:phone_number]} must be a 10 digit string")
    end
  end

  describe "request with invalid start date" do
    params = {
        first_name: "Ash",
        last_name: "Ketchum",
        phone_number: "512123123",
        college_id: 1,
        exam_id: 1,
        start_time: "2020-12-20 11:00 AM",
    }
    it "should respond with 400" do
      post "/user_exams/new", params: params
      expect(response.status).to eq(400)
    end
    it "should give start time validation message" do
      post "/user_exams/new", params: params
      r = JSON.parse(response.body)
      expect(r['message']).to eq("start_time #{params[:start_time]} is in an invalid format.  Please use %Y-%m-%d %H:%M:%S")
    end
  end

end
