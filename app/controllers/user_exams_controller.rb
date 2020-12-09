class UserExamsController < ApplicationController

  def create

    @user_exam = UserExam.new

    # check college exists
    unless College.find_by_id(params[:college_id])
      render json: "college_id #{params[:college_id]} not found in database" , status: 400
    end

    # check exam exists and belongs to college
    exam = Exam.find_by_id(params[:exam_id])
    if exam
      unless exam.belongs_to_college(college)
        render json: "exam_id #{params[:exam_id]} doesn't belong to college_id #{params[:college_id]}" , status: 400
      end
      # check that start_time is in time_window of exam
      unless exam.exam_window.within_window(params[:start_time])
        render json: "start_time #{params[:start_time]} is outside the time window for the exam" , status: 400
      end
    else
      render json: "exam_id #{params[:exam_id]} not found in database" , status: 400
    end

    # find or create user
    user = User.find_by(
        first_name: params[:first_name],
        last_name: params[:last_name],
        phone_number: params[:phone_number]
    )
    unless user
      begin
        user = User.new
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.phone_number = params[:phone_number]
        user.save!
      rescue StandardError => e
        render json: e, status: 400
      end
    end

    # user_exam already exists
    unless UserExam.find_by(user_id: user.id,exam_id: exam.id)
      begin
        user_exam = UserExam.new
        user_exam.user_id = user.id
        user_exam.exam_id = exam.id
        user_exam.save!
      rescue StandardError => e
        render json: e, status: 400
      end
    end

    # return success if all is good, assgning user
    render json: "User Successfully Assigned To Exam" , status: 200

  end

  private



end
