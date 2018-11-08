class RelationshipsController < ApplicationController

  #create validations
  #once i select a user to match with based on if they're status is pending
  def index
    relationships = Relationship.all

    render json: relationships
  end

  def show
    # @relationship = Relationship.find(params[:id])
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

  # def exists
  #   if Relationship.where(followed_id: current_user.id).present? || Relationship.where(follower_id: current_user.id).present?
  #
  #       if Relationship.where(follower_id: current_user.id).pluck(:followed_id).include?(other_user.id) || Relationship.where(followed_id: current_user.id).pluck(:follower_id).include?(other_user.id)
  #           render json: {error: 'Relationship Exists'}, status: 401
  #       else
  #         Relationship.create(follower_id: current_user.id, followed_id: other_user.id)
  #       end
  #   else
  #     matches = User.all.select { |user| user != current_user && user.dogs == current_user.dogs }
  #     matches.each{ |user| Relationship.create(follower_id: current_user.id, followed_id: user.id) }
  #         end
  #     end

  private
    def relationship_params
      params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
