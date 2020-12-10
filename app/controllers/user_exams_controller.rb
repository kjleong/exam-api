class UserExamsController < ApplicationController

  before_action :init_render_output, only:[:create]

  def create

    validate_start_date(params[:start_time])
    validate_name(params[:first_name])
    validate_name(params[:last_name])
    validate_phone_number(params[:phone_number])

    # check college exists
    college = College.find_by_id(params[:college_id])
    unless college
      set_render_output "college_id #{params[:college_id]} not found in database", 400
    end

    # check exam exists and belongs to college
    exam = Exam.find_by_id(params[:exam_id])
    if exam
      unless exam.belongs_to_college(college)
        set_render_output "exam_id #{params[:exam_id]} doesn't belong to college_id #{params[:college_id]}" , 400
      end
      # check that start_time is in time_window of exam
      unless exam.within_time_window(params[:start_time])
        set_render_output "start_time #{params[:start_time]} is outside the time window for the exam" , 400
      end
    else
      set_render_output "exam_id #{params[:exam_id]} not found in database" , 400
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
        set_render_output e,  400
      end
    end

    # user_exam already exists
    if user && exam && UserExam.find_by(user_id: user.id, exam_id: exam.id)
      set_render_output "User #{user.id} already assigned to specified exam #{exam.id}", 400
    else
      begin
        user_exam = UserExam.new
        user_exam.user_id = user.id
        user_exam.exam_id = exam.id
        user_exam.save!
      rescue StandardError => e
        set_render_output e, 400
      end
    end

    $stderr.puts @render_output

    # return success if all is good, assigning user
    if @render_output.nil?
      render json: "User Successfully Assigned To Exam" , status: 200
    else
      render json: {:errors => @render_output[:message]}, status: @render_output[:code]
    end

  end

  private

  def init_render_output
    @render_output = nil
  end

  def set_render_output(message,code)
    if @render_output.nil?
      @render_output = {
          message:message,
          code:code,
      }
    end
  end

  def validate_name(name)
    if name.instance_of? String
      true
    else
      set_render_output("#{name} must be a string",400)
      false
    end
  end

  def validate_phone_number(phone_number)
    if phone_number.scan(/\D/).empty? && phone_number.length == 10
      true
    else
      set_render_output("#{phone_number} must be a 10 digit string",400)
      false
    end
  end

  def validate_start_date(start_time)
    can_format =  DateTime.strptime(start_time, '%Y-%m-%d %H:%M:%S') rescue false
    if can_format == false
      set_render_output "start_time #{start_time} is in an invalid format.  Please use %Y-%m-%d %H:%M:%S", 400
      return false
    end
    true
  end

end
