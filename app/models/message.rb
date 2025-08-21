class Message < ApplicationRecord
  belongs_to :conversation

  validates :content, presence: true
  validates :role, presence: true, inclusion: { in: %w[user assistant] }

  SYSTEM_PROMPT = "<<~PROMPT
    You are a friendly sport events organizer whose goal is to help people meet others through sport events."
end
