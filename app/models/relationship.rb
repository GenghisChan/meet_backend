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

def self.findUser(user_id)
  found_users = []
  current_user = User.find(user_id).id
  if self.where("follower_id=?" || "following_id", current_user).present?
    self.where("follower_id=?", current_user).pluck(:followed_id).map { |user|
      found_users.push(User.find(user))
    }
    self.where("followed_id=?", current_user).pluck(:follower_id).map { |user|
      found_users.push(User.find(user))
    }
    found_users #these are all of the matches
  elsif found_users.empty?
    puts "no users found"
  end
end
# 
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
