class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :follower_id, :followed_id
  belongs_to :user
end

# def find_follower
#   User.find(:follower_id)
# end
#
# def find_followed
#   User.find(:followed_id)
# end
