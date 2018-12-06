class Conversation < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :receiver, class_name: "User"
  validates :author_id, presence: true
  validates :receiver_id, presence: true
  validates :author, uniqueness: {scope: :receiver}

  scope :participating, -> (user) do
    where("(conversations.author_id = ? OR conversations.receiver_id = ?)", user.id, user.id)
  end

  has_many :messages
end
