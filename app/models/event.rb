class Event < ApplicationRecord
  has_many :event_participations, dependent: :destroy
  has_many :users, through: :event_participations, source: :user
  has_many :participants, through: :event_participations, source: :user
  belongs_to :user

  def starts_at
    value = super
    value.is_a?(String) ? Time.parse(value) : value
  end

  def ends_at
    value = super
    value.is_a?(String) ? Time.parse(value) : value
  end
end
