class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    if @user
      render json: @user, status: 200
    else
      render json: "unable to find user #{params[:id]}"
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: 200
    else
      render json: "user creation error"
    end
  end

  private

  def set_user
    @user = User.find_by([params[:id]])
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:phone_number)
  end

end
