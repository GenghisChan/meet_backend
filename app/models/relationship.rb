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



  # def create
  #   @user = Relationship.all.select {|user| Relationship.follow}
  #


end

#match ...
#if user 1 and user 2 both say yes .. status = "friends" and show up on each others matches
#if one of the users say no .. then status = "rejected"
#do i need a column for each of their answers ?? user_1 yes/no user 2 yes/no status = 'pending'

#on "meet" pull a random user pair and show each other ..
#on
