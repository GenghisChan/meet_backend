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

  def paired ## shows all matches ...
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

  def find_matches ##creates matches
    matches = User.all.select { |user| ##finds all people that like dogs
        user != self && user.dogs == self.dogs ## and is not self
    } # array of ppl
    # for each user that like or dont like dogs .. create a
    #new relationship if it doesnt exist yet ..
    matches.each{ |user| Relationship.findUser(self, user) } # each user is created with those pairs 
        # should create instances of relationships... if it doesnt already exist in either direction
        #for each user check if the relationship exists
        # in either column

        #find out why relationships are not being created
  end



end
