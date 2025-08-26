class Event < ApplicationRecord
  has_many :event_participations, dependent: :destroy
  has_many :users, through: :event_participations
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
