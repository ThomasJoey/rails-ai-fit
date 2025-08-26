class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations

  has_many :messages
  has_many :conversations
  has_many :second_conversations, class_name: "Conversation", foreign_key: :second_user_id

  has_many :message_users, foreign_key: :sender_id

  has_one_attached :avatar
  has_many :posts
  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Scopes
  scope :near_location, ->(location, distance = 10) {
    near(location, distance, units: :km)
  }

  # Validations
  validates :location, presence: true, if: :location_required?
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

  def find_existing_conversation(user)
    Conversation.where(user: self, second_user: user)
                .or(Conversation.where(user: user, second_user: self))
                .first
  end

  private

  def location_required?
    false # Mettez true si vous voulez rendre la localisation obligatoire
  end

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.blob.byte_size <= 5.megabyte
      errors.add(:avatar, "est trop lourd (max 5MB)")
    end

    acceptable_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    unless acceptable_types.include?(avatar.blob.content_type)
      errors.add(:avatar, "doit être une image JPEG, PNG, GIF ou WebP")
    end
  end
end
