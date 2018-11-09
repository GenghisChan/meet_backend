class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :dogs
  has_many :active_relationships
  has_many :passive_relationships
end
