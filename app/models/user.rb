class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }, presence: true
  validates :password, presence: true, length: { in: 6..20 }
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 18, message: "Must Be older than 18 to use sign up"}
  validates :bio, length: { maximum: 500 }
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

                                   has_many :authored_conversations,  class_name:  "Conversation",
                                                                      foreign_key: "author_id",
                                                                      dependent:   :destroy
                                     has_many :received_conversations, class_name:  "Conversation",
                                                                      foreign_key: "receiver_id",
                                                                      dependent:   :destroy
                                     has_many :outgoing, through: :authored_conversations,  source: :receiver
                                     has_many :incoming, through: :received_conversations, source: :author

has_many :messages

  def new_user
    reg = incoming + outgoing
    dif = (User.all - [self]) - reg
    return dif
  end

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

  def new_user
   reg = incoming + outgoing
   dif = (User.all - [self]) - reg
   return dif
 end


  def display_matches
    found_users = []
    self.find_matches
    if Relationship.where({follower_id: self.id, status: "pending"})
      Relationship.where({follower_id: self.id, status: "pending", follower_answer: nil}).pluck(:followed_id).map do |user|
        followed = {user: User.find(user), isFollowed: true }
        found_users.push(followed)
      end
    end

      if Relationship.where({followed_id: self.id, status: "pending"})
        Relationship.where({followed_id: self.id, status: "pending", followed_answer: nil}).pluck(:follower_id).map do |user|
        follower = {user: User.find(user), isFollowed: false }
        found_users.push(follower)
      end
      end

    found_users.sample
  end


  def find_matches
    matches = User.all.select do |user| #this is saying if relationship doesnt exist.. make it... but .. i need to find matches for all users
      user != self && user.dogs == self.dogs && self.find_new_relationships(user)
    end

    if matches.length != 0
      Relationship.create(follower_id: self.id, followed_id: matches.sample.id) ## this creates the relationships ...
    else
      nil
    end

  end

  def find_new_relationships(random_user)
    if Relationship.where(follower_id: self.id).pluck(:followed_id).include?(random_user.id) || Relationship.where(followed_id: self.id).pluck(:follower_id).include?(random_user.id)
      # render json: {error: 'Relationship Exists'}, status: :not_acceptable
      return false
    else
      return true
    end
  end

end
