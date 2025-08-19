class Conversation < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :title, :context, presence: true
end
