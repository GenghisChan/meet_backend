class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates :username, uniqueness: { case_sensitive: false }

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy


  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def invalidate_token
    self.update_columns(auth_token: nil)
  end

  def self.validate_login(username, password)
    user = find_by(username: username)
    if user && user.authenticate(password)
      user
    end
  end

  def paired
    found_users = []

    if Relationship.where(follower_id: self.id).present?
      Relationship.where(follower_id: self.id).pluck(:followed_id).map { |user|
        found_users.push(User.find(user))
      }
    end

      if Relationship.where(followed_id: self.id).present?
        Relationship.where(followed_id: self.id).pluck(:follower_id).map { |user|
        found_users.push(User.find(user))
      }
      end

      found_users
  end

  def find_matches
    matches = User.all.select { |user|
      user != self && user.dogs == self.dogs
    }
    matches.each{ |user| Relationship.findUser(self, user) }
  end

end
