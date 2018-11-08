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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def paired
    found_users = []

    if Relationship.where(follower_id: self.id).present?
      Relationship.where(follower_id: self.id).pluck(:followed_id).map do |user|
        found_users.push(User.find(user))
      end
    end

      if Relationship.where(followed_id: self.id).present?
        Relationship.where(followed_id: self.id).pluck(:follower_id).map do |user|
        found_users.push(User.find(user))
      end
      end

      found_users
  end

  def find_matches
    matches = User.all.select do |user|
      user != self && user.dogs == self.dogs && find_users_in_relationship(user)
    end

    if matches.length != 0
      Relationship.create(follower_id: self.id, followed_id: matches.sample.id)
    else
      false
    end

  end

  def find_users_in_relationship(random_user)
    if Relationship.where(follower_id: self.id).pluck(:followed_id).include?(random_user.id) || Relationship.where(followed_id: self.id).pluck(:follower_id).include?(random_user.id)
      # render json: {error: 'Relationship Exists'}, status: :not_acceptable
      return false
    else
      return true
    end
  end

end

# else
#   Relationship.create(follower_id: self.id, followed_id: random_user.id)
# end

# def find_matches
#   matches = User.all.select { |user|
#     user != self && user.dogs == self.dogs
#   }
#   matches.each{ |user| Relationship.find_user(self, user) }
# end
