class Conversation < ApplicationRecord
  # has_many :followers, class_name: "User"
  # has_many :followeds, class_name: "User"
  # validates :follower_id, presence: true
  # validates :followed_id, presence: true

  # has_many :following, through: :messages, source: :followed
  # has_many :followers, through: :messages

  has_many :messages

end
