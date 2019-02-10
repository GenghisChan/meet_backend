class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :follower_id, :followed
  belongs_to :follower
  belongs_to :followed

  def followed
    object.followed
  end

end
