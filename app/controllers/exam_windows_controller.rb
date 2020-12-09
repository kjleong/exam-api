class ExamWindowsController < ApplicationController
  before_action :set_exam_window, only: :show

  def index
    @exam_windows = ExamWindow.all
    render json: @exam_windows, status: 200
  end

  def show
    if @exam_window
      render json: @exam_window, status: 200
    else
      render json: "unable to find exam_window #{params[:id]}"
    end
  end

  def create
    @exam_window = ExamWindow.new(exam_window_params)

    if @exam_window.save
      render json: @exam_window, status: 200
    else
      render json: "exam_window creation error"
    end
  end

  private

  def set_exam_window
    @exam_window = ExamWindow.find_by([params[:id]])
  end

  def exam_window_params
    params.require(:exam_window).permit(:first_name,:last_name,:phone_number)
  end
  
end
