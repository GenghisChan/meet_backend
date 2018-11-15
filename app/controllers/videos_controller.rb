class VideosController < ApplicationController

  def create

  head :no_content
  ActionCable.server.broadcast "videos_channel", video_params
  end

private

def video_params
  params.require(:video).permit(:type, :from, :to, :sdp, :candidate, :renegotiate)
end

end






# def create
#   video = Video.new(video_params)
#   conversation = Conversation.find(video_params[:conversation_id])
#   if video.save
#     serialized_data = ActiveModelSerializers::Adapter::Json.new(
#       VideoSerializer.new(video)
#     ).serializable_hash
#     VideosChannel.broadcast_to conversation, serialized_data
#     head :ok
#   end
# end
#
#   private
#
#   def video_params
#     params.require(:video).permit(:conversation_id, :user_id, :sdp)
#   end
