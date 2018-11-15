class ConversationsController < ApplicationController
  before_action :authorized

  def index
    conversations = Conversation.all
    render json: conversations
  end

  def create
    conversation = Conversation.find_or_initialize_by(conversation_params)
    if conversation.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(conversation)
      ).serializable_hash
      ActionCable.server.broadcast 'conversations_channel', serialized_data
      head :ok
    end
  end


  private

  def conversation_params
    params.require(:conversation).permit(:title, :follower_id, :followed_id)
  end
end
