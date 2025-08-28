class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Constantes pour les tranches d'âge
  AGE_RANGES = [
    ['18-25 ans', '18-25'],
    ['26-35 ans', '26-35'],
    ['36-45 ans', '36-45'],
    ['46-55 ans', '46-55'],
    ['56-65 ans', '56-65'],
    ['66+ ans', '66+']
  ].freeze

  # Associations
  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations
  has_many :messages, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :second_conversations, class_name: "Conversation", foreign_key: :second_user_id
  has_many :message_users, foreign_key: :sender_id
  has_one_attached :avatar
  has_many :posts, dependent: :destroy

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Scopes
  scope :near_location, lambda { |location, distance = 10|
    near(location, distance, units: :km)
  }

  # Validations
  validates :location, presence: true, if: :location_required?
  validates :age_range, inclusion: {
    in: AGE_RANGES.map(&:last),
    message: "doit être une tranche d'âge valide"
  }, allow_blank: true
  validate :acceptable_avatar

  # Méthode pour obtenir l'URL de l'avatar ou une image par défaut
  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      # Image par défaut - vous pouvez utiliser une image locale ou un service comme Gravatar
      "https://ui-avatars.com/api/?name=#{email}&background=random"
    end
  end

  # Nom d'affichage: prénom + nom si présents, sinon base de l'email
  def display_name
    name = [first_name, last_name].compact_blank.join(" ")
    return name if name.present?

    return email.to_s.split("@").first.presence || "Utilisateur"
  end

  # Localisation d'affichage (préférence: city puis location)
  def display_location
    [city, location].compact_blank.first
  end

  def find_existing_conversation(user)
    Conversation.where(user: self, second_user: user)
                .or(Conversation.where(user: user, second_user: self))
                .first
  end

  # Méthode helper pour afficher la tranche d'âge en format lisible
  def age_range_display
    age_range.present? ? AGE_RANGES.find { |_label, value| value == age_range }&.first : nil
  end

  private

  def location_required?
    false # Mettez true si vous voulez rendre la localisation obligatoire
  end

  def acceptable_avatar
    return unless avatar.attached?

    errors.add(:avatar, "est trop lourd (max 5MB)") unless avatar.blob.byte_size <= 5.megabyte

    acceptable_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    return if acceptable_types.include?(avatar.blob.content_type)

    errors.add(:avatar, "doit être une image JPEG, PNG, GIF ou WebP")
  end
end
