class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def index
    @users = User.all

    render json: @users
  end

  def create
      @user = User.create(user_params)
      if @user.valid?
        render json: @user, status: :created
      else
        render json: @user.errors.full_messages, status: :not_acceptable
      end
    end

  def show
    @user = User.find(params[:id])

    render json: @user
  end

    def profile
      render json: current_user, status: :accepted
    end

    def found_match
      @relationship = current_user.display_matches

      if @relationship
        render json: @relationship, status: :created
      else
        render json: {error: 'no user found'}
      end
    end

    def update
      @user = User.find(params[:id])

      @user.update(user_params)
      render json: @user
    end

    def show_matches
      matches = current_user.show_people

      render json: matches
    end


    private


    def user_params
      params.require(:user).permit(:username, :password, :age, :sex, :location, :bio, :img_url, :online, :status)
    end

  end






# def find_relationships
#   if Relationship.where(followed_id: current_user.id).present? || self.where(follower_id: current_user.id).present?
#
#
#
#   else
#     matches = User.all.select { |user| user != current_user && user.dogs == current_user.dogs }
#     matches.each{ |user| Relationship.create(follower_id: current_user.id, followed_id: user.id) }
#   end
# end
