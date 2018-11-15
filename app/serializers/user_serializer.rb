class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :dogs, :age, :sex, :location, :bio, :img_url, :online
  has_many :active_relationships
  has_many :passive_relationships
end
