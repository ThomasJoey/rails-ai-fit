class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :second_user, class_name: 'User', optional: true
  has_many :messages, dependent: :destroy
  has_many :message_users, dependent: :destroy

  validates :title, presence: true
  TITLE_PROMPT = <<~PROMPT
    Generate a short, descriptive, 3-to-6-word title that summarizes the user question for a chat conversation.
  PROMPT

  scope :between, ->(u1, u2) {
    where(
      "(user_id = :u1 AND second_user_id = :u2) OR (user_id = :u2 AND second_user_id = :u1)",
      u1: u1.id,
      u2: u2.id
    )
  }

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

  # Affiche le bouton "Générer l'événement" seulement si le dernier
  # message utilisateur contient au moins une heure ET un jour/date.
  def ready_for_event_generation?
    last_user_msg = messages.where(role: "user").order(:created_at).last
    return false if last_user_msg.nil?

    content = last_user_msg.content.to_s.downcase

    # Heures: "12h", "9h30", "14:00"
    time_regex = /(\b\d{1,2}\s*h(?:\s*\d{2})?\b|\b\d{1,2}:\d{2}\b)/

    # Jours français et formats de dates simples: "demain", "lundi", "12/09", "29 août"
    day_words = %w[aujourd'hui demain lundi mardi mercredi jeudi vendredi samedi dimanche]
    day_word_present = day_words.any? { |w| content.include?(w) }

    numeric_date_regex = /\b\d{1,2}\s*\/\s*\d{1,2}(?:\s*\/\s*\d{2,4})?\b/
    month_words_regex = /(janv|févr|fevr|mars|avr|mai|juin|juil|août|aout|sept|oct|nov|déc|dec)/

    has_time = content.match?(time_regex)
    has_day_or_date = day_word_present || content.match?(numeric_date_regex) || content.match?(month_words_regex)

    has_time && has_day_or_date
  end

  def self.between(user1, user2)
    where(
      "(second_user_id = :u1 AND user_id = :u2) OR (second_user_id = :u2 AND user_id = :u1)",
      u1: user1.id,
      u2: user2.id
    )
  end

end
