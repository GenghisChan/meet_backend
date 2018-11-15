class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user, :conversation_id, :text, :created_at

  belongs_to :user
end
