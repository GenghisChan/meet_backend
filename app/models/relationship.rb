class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  #before Relationship is created
  #check to see if user pair exists already in either column
  #we dont want duplicates of a relationship because they are both users
  #to show up on each others 'friends' list check both columns for the current_user, and return the other user, depending on if they are friends
  #through a relationship status 'pending' that is dependent on the requested users action(answer)
  #if user_b actions => status = 'friends', 'rejected', 'pending' <<< default once user relationship is created ..
  #find current user && user 2 in both columns .. if the pair already exists dont create it, otherwise do create it ..
  #are relationships created immediately based on peoples answers ..? because they will eventually show on each others searches?
# || self.where("followed_id=?",current_user)

def self.findUser(user1, user2) #current_user adding user
  current_user = User.find(user1.id)
  if self.where("follower_id=?" || "following_id=?", current_user).present?

    follower = self.where("follower_id=?", current_user).pluck(:followed_id).map { |user|
      if user == user2
        true
      end
      }

        followed = self.where("followed_id=?", current_user).pluck(:follower_id).map { |user|
          if user == user2
            true
          end
        }

      if follower == true && followed == true
        puts "Relationship Exists"
      else
        Relationship.create(follower_id: user1.id, followed_id: user2.id)
      end

  end
end


# on user click for matches ... run self.findUser(current_user)


# def test
#   Relationship.findUser(1)
# end
#match ...
#if user 1 and user 2 both say yes .. status = "friends" and show up on each others matches
#if one of the users say no .. then status = "rejected"
#do i need a column for each of their answers ?? user_1 yes/no user 2 yes/no status = 'pending'

#on "meet" pull a random user pair and show each other ..
#on
end
