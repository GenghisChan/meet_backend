class UsersController < ApplicationController

  def index
    @users = User.all

    render json: @users
  end

  def show
    @user = User.find(params[:id])

    render json: @user
  end

  def create
    byebug
    @user = User.create(user_params)

    if @user.valid?
      @user
    else
      render json: @user.errors.full_messages
  end
end


  private

  def user_params
    params.require(:user).permit(:username, :dogs)
  end

end
