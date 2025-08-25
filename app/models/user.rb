class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations

  def find_existing_conversation(user)
    Conversation.where(user: self, second_user: user)
                .or(Conversation.where(user: user, second_user: self))
                .first
  end
end
