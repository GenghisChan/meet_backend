class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :title, :follower_id, :followed_id
  has_many :messages
  # has_many :users, through: :messages
end
