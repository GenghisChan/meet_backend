class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

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

    def profile
      render json: current_user, status: :accepted
    end

    def found_match
      @relationship = current_user.find_matches

      if @relationship
        render json: @relationship, status: :created
      else
        render json: {error: 'Relationship already exists'}, status: :not_acceptable
      end
    end

    def show_matches
      matches = current_user.paired

      render json: matches
    end


    private

    def user_params
      params.require(:user).permit(:username, :password)
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
