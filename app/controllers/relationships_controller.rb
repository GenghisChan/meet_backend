class RelationshipsController < ApplicationController
  before_action :authorized
  after_action :change_status, only: [:update]

  #create validations
  #once i select a user to match with based on if they're status is pending
  def index
    relationships = Relationship.all

    render json: relationships
  end

  def show
    match = current_user.find_matches.id
    render json: info
  end

  def create
    @relationship = Relationship.create(relationship_params)
    if @relationship.valid?
      render json: @relationship, status: :created
    else
      render json: {message: 'Could not create relationship'}
    end
  end


  def update
    relationship = find_relationship(params[:relationship][:current_user_id], params[:relationship][:match_id])[0]
    if relationship.follower_id == params[:relationship][:current_user_id]
      relationship.update(follower_answer: params[:relationship][:response])
    else
      relationship.update(followed_answer: params[:relationship][:response])
    end
    render json: relationship
  end

  def find_relationship(current_user, match_user)
    if Relationship.where(followed_id: match_user, follower_id: current_user).length > 0
      return Relationship.where(followed_id: match_user, follower_id: current_user)
    elsif Relationship.where(follower_id: match_user, followed_id: current_user).length > 0
      return Relationship.where(follower_id: match_user, followed_id: current_user)
    else
      return nil
    end
  end


  def change_status
    relationship = find_relationship(params[:relationship][:current_user_id], params[:relationship][:match_id])[0]


    if relationship.follower_answer === true && relationship.followed_answer === true
      relationship.update(status: 'friends')

    elsif relationship.follower_answer === false || relationship.followed_answer === false && relationship.follower_answer != nil || relationship.followed_answer != nil
      relationship.update(status: 'rejected')

    else
      return nil
    end
  end

  private


    def relationship_params
      params.require(:relationship).permit(:current_user_id, :match_id, :follower_answer, :followed_answer, :response, :status)
    end
end
