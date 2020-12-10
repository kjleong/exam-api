class ExamsController < ApplicationController

  before_action :set_exam, only: :show

  def index
    @exams = Exam.all
    render json: @exams, status: 200
  end

  def show
    render json: @exam, status: 200
  end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      render json: @exam, status: 200
    else
      render json: "exam creation error"
    end
  end

  private

  def set_exam
    @exam = Exam.find_by([params[:id]])
  end

  def exam_params
    params.require(:exam).permit(:name,:college_id,:exam_window_id)
  end
  
end
