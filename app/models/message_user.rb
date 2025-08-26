class MessageUser < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User"

  validates :content, presence: true, length: { maximum: 2000 }

  scope :chronological, -> { order(:created_at) }

end
