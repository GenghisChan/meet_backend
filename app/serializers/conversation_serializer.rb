class ConversationSerializer < ActiveModel::Serializer
  attributes :receiver, :author, :id, :messages
  has_many  :messages


end
