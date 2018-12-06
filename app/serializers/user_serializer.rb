class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :dogs, :age, :sex, :location, :bio, :img_url, :online
  has_many :active_relationships
  has_many :passive_relationships
  has_many :conversations

  def conversations
      Conversation.participating(object)
    end

    def inactive
      reg = object.incoming + object.outgoing
      dif = (User.all - [object]) - reg
      return dif
    end

end
