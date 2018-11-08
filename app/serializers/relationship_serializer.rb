class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :follower_id, :followed
  belongs_to :follower
  belongs_to :followed
  # belongs_to :followed, serializer: ShallowUserSerializer
  # def followed
  #   ShallowUserSerializer.new(object.followed)
  # end
#
  def followed
    # user = ShallowUserSerializer.new(User.find(object.followed.id))
    object.followed
  end

end

# def find_follower
#   User.find(:follower_id)
# end
#
# def find_followed
#   User.find(:followed_id)
# end
