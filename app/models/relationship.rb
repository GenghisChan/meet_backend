class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

## not creating new relationships .. when a pair already exi

def self.findUser(current_user, other_user) #current_user adding user if new user <<<<
  if self.where(followed_id: current_user.id).present? || self.where(follower_id: current_user.id).present?

    if self.where(follower_id: current_user.id).present?
      followed = self.where(follower_id: current_user.id).pluck(:followed_id).map { |followed|
        followed == other_user # goes through each id of followed column and compares it with the passed in user
        true
      }  elsif self.where(followed_id: current_user.id).present?
          follower = self.where(followed_id: current_user.id).pluck(:follower_id).map { |follower|
            follower == other_user
              true
        }
      end

      if follower
          puts "follower Exists"
        elsif followed
          puts "followed exists"## this is for existing followers that have already matched with users
        else# but if someone else signs up it adds those new users to list
          Relationship.create(follower_id: current_user.id, followed_id: other_user.id) # MAKING DUPLICATES OF RELATIONSHIPS
        end

        else
          matches = User.all.select { |user|
              user != current_user && user.dogs == current_user.dogs
          }

          matches.each{ |user| Relationship.create(follower_id: current_user.id, followed_id: user.id) }
        end
    end
end










#before Relationship is created
#check to see if user pair exists already in either column
#we dont want duplicates of a relationship because they are both users
#to show up on each others 'friends' list check both columns for the current_user, and return the other user, depending on if they are friends
#through a relationship status 'pending' that is dependent on the requested users action(answer)
#if user_b actions => status = 'friends', 'rejected', 'pending' <<< default once user relationship is created ..
#find current user && user 2 in both columns .. if the pair already exists dont create it, otherwise do create it ..
#are relationships created immediately based on peoples answers ..? because they will eventually show on each others searches?
# || self.where("followed_id=?",current_user)


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
