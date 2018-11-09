class Message < ApplicationRecord
  belongs_to :conversation
  # belongs_to :follower, class_name: "User"
  # belongs_to :followed, class_name: "User"

end
