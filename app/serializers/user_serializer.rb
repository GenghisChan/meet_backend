class UserSerializer < ActiveModel::Serializer
  attributes :username, :password_digest, :dogs
  has_many :active_relationships
  has_many :passive_relationships
end
