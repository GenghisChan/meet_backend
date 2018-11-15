class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }

  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy


  # has_many :following, through: :active_relationships, source: :followed
  # has_many :followers, through: :passive_relationships
  has_many :conversations, through: :messages
  has_many :messages


  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def show_people
    found_users = []

     if Relationship.where({follower_id: self.id, status: 'friends'})
      Relationship.where({follower_id: self.id, status: 'friends'}).pluck(:followed_id).map do |user|
        followed = {user: User.find(user), isFollowed: true }
        found_users.push(followed)
      end
    end

    if Relationship.where({followed_id: self.id, status: 'friends'})
        Relationship.where({followed_id: self.id, status: 'friends'}).pluck(:follower_id).map do |user|
        follower = {user: User.find(user), isFollowed: false }
        found_users.push(follower)
        end
      end

    found_users
  end


  def display_matches
    found_users = []
    self.find_matches
    if Relationship.where(follower_id: self.id).present?
      Relationship.where(follower_id: self.id).pluck(:followed_id).map do |user|
        followed = {user: User.find(user), isFollowed: true }
        found_users.push(followed)
      end
    end

      if Relationship.where(followed_id: self.id).present?
        Relationship.where(followed_id: self.id).pluck(:follower_id).map do |user|
        follower = {user: User.find(user), isFollowed: false }
        found_users.push(follower)
      end
      end

    found_users.sample
  end


  def find_matches
    matches = User.all.select do |user| #this is saying if relationship doesnt exist.. make it... but .. i need to find matches for all users
      user != self && user.dogs == self.dogs && self.find_users_in_relationship(user)
    end

    if matches.length != 0
      Relationship.create(follower_id: self.id, followed_id: matches.sample.id) ## this creates the relationships ...
    else
      nil
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

#need to find relationship.. return it..

# def find_relationship(random_user)
#   if Relationship.where(followed_id: random_user.id, follower_id: self.id).length > 0
#     Relationship.where(followed_id: random_user.id, follower_id: self.id)
#   elsif Relationship.where(follower_id: random_user.id, followed_id: self.id).length > 0
#     Relationship.where(followed_id: random_user.id, follower_id: self.id)
#   else
#     Relationship.create(follower_id: self.id, followed_id: random_user.id)
#   end
# end
