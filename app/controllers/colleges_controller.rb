class CollegesController < ApplicationController
  before_action :set_college, only: :show

  def index
    @colleges = College.all
    render json: @colleges, status: 200
  end

  def show
    render json: @college, status: 200
  end

  def create
    @college = College.new(college_params)

    if @college.save
      render json: @college, status: 200
    else
      render json: "college creation error"
    end
  end

  private

  def set_college
    @college = College.find_by([params[:id]])
  end

  def college_params
    params.require(:college).permit(:name)
  end
end
