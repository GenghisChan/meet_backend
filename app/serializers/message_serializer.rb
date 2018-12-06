class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :text, :created_at, :author_name, :user_id

  def author_name
    User.find(object.user_id).name
  end
end
