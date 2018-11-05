class RelationshipsController < ApplicationController

  def index
    @relationships = Relationship.all

    render json: @relationships
  end

  def show
    @relationship = Relationship.find(params[:id])

    render json: @relationship
  end

  def create
    @relationship = Relationship.create(relationship_params)
    byebug
    if @relationship.valid?
      render json: @relationship
    else
      render json: @relationship.errors.full_messages

  end

  private
    def relationship_params
      params.require(:relationship).permit(:follower_id, followed_id:)
    end
end
