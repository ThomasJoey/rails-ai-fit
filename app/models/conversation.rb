class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :second_user, class_name: 'User', optional: true
  has_many :messages, dependent: :destroy
  has_many :message_users, dependent: :destroy

  validates :title, presence: true
  TITLE_PROMPT = <<~PROMPT
    Generate a short, descriptive, 3-to-6-word title that summarizes the user question for a chat conversation.
  PROMPT

  def generate_title_from_first_message
    first_user_message = messages.where(role: "user").order(:created_at).first
    return if first_user_message.nil?

    response = RubyLLM.chat.with_instructions(TITLE_PROMPT).ask(first_user_message.content)
    update(title: response.content)
  end
  
  def participants
    [user, second_user].compact
  end

  def participant?(u)
    participants.include?(u)
  end

  def human_chat?
    second_user_id.present?
  end

  def ai_chat?
    !human_chat?
  end

  def display_name_for(current_user)
    if second_user_id.present?
      # conversation entre utilisateurs → afficher l'autre participant
      other = (current_user == user ? second_user : user)
      other&.first_name || other&.email || "Conversation"
    else
      # conversation IA
      title.presence || "Nouvelle conversation"
    end
  end
end
