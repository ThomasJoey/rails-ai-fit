class EventParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :event_participations
  has_many :users, through: :event_participations
  validates :user_id, uniqueness: { scope: :event_id, message: "est déjà inscrit à cet événement" }
end
