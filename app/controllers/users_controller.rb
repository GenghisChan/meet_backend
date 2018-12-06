class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :show]

  def index
    @users = User.all

    render json: @users
  end

  def create
      @user = User.create(user_params)
      if @user.valid?
          token = issue_token({id: @user.id})
          render json: {jwt: token, user: @user}, status: :accepted
      else
        render json: { error: @user.errors.full_messages }, status: :unprocessible_entity
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
      # byebug

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

def followers
  @user = User.find_by(name:params[:currentU])
  @other = User.find_by(name:params[:otherU])
  @conversation = Conversation.new(author_id:@user.id,receiver_id:@other.id)

  if @conversation.save
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      ConversationSerializer.new(@conversation)
    ).serializable_hash
    ActionCable.server.broadcast 'conversations_channel', serialized_data
    head :ok
  end

  render json: @conversation
end


    private


    def user_params
      params.require(:user).permit(:username, :password, :dogs, :age, :sex, :location, :bio, :img_url, :online, :status)
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
