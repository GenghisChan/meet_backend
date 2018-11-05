class UserSerializer < ActiveModel::Serializer
  attributes :username, :password_digest, :dogs, :auth_token
end
