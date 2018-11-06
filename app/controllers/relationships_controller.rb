class RelationshipsController < Appl

  def index
    @relationships = Relationship.all

    render json: {relationships: @relationships}
  end

  def show
    @relationship = Relationship.find(params[:id])

    render json: @relationship
  end

  def create
    @relationship = Relationship.create(relationship_params)

    if @relationship.valid?
      render json: {message: 'ok', relationship: @relationship}
    else
      render json: {message: 'Could not create relationship'}
    end
  end

  private
    def relationship_params
      params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
