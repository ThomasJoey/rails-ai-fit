class EventParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user_id, uniqueness: { scope: :event_id, message: "est déjà inscrit à cet événement" }
end
