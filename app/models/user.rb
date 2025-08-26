class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations
  has_many :messages
  has_many :conversations
  has_many :second_conversations, class_name: "Conversation", foreign_key: :second_user_id

  has_many :message_users, foreign_key: :sender_id

  def find_existing_conversation(user)
    Conversation.where(user: self, second_user: user)
                .or(Conversation.where(user: user, second_user: self))
                .first
  end
end
