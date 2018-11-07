class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :find_user, on: :create


def self.find_user(current_user, other_user)
  if self.where(followed_id: current_user.id).present? || self.where(follower_id: current_user.id).present?

      if self.where(follower_id: current_user.id).pluck(:followed_id).include?(other_user.id) || self.where(followed_id: current_user.id).pluck(:follower_id).include?(other_user.id)
        puts "current_user: #{current_user.username}"
        puts "other_user: #{other_user.username}"
      else
        Relationship.create(follower_id: current_user.id, followed_id: other_user.id)
      end

  else
    matches = User.all.select { |user| user != current_user && user.dogs == current_user.dogs }
    matches.each{ |user| Relationship.create(follower_id: current_user.id, followed_id: user.id) }
        end
    end
end
