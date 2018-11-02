class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: { case_sensitive: false }

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy


  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  def follow(other_user) #users I decide to follow,
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def matches
    found_users = []

    if Relationship.where("follower_id=?", self).present?
      Relationship.where("follower_id=?", self).pluck(:followed_id).map { |user|
        found_users.push(User.find(user))
      }
    end

      if Relationship.where("followed_id=?", self).present?
        Relationship.where("followed_id=?", self).pluck(:follower_id).map { |user|
        found_users.push(User.find(user))
      }
      end

      found_users
  end



end
