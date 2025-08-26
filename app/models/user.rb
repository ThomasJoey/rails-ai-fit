class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations
end

class User < ApplicationRecord
  # Devise modules...

  has_one_attached :avatar

  # Méthode pour obtenir l'URL de l'avatar ou une image par défaut
  def avatar_url
    if avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
    else
      # Image par défaut - vous pouvez utiliser une image locale ou un service comme Gravatar
      "https://ui-avatars.com/api/?name=#{email}&background=random"
    end
  end

  # Validation optionnelle pour le type et la taille du fichier
  validate :acceptable_avatar

  private

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
