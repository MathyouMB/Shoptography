# Represents a entity that has been purchased (likely an Image)
class Purchase < ApplicationRecord
  # Validations
  validates :title, presence: true
  validates :cost, presence: true

  # Relations
  belongs_to :user
  belongs_to :merchant, class_name: 'User', foreign_key: 'merchant_id', required: false

  # Active Storage
  has_one_attached :attached_image

  # Methods
  def attached_image_url
    Rails.application.routes.url_helpers
      .rails_blob_url(attached_image, only_path: true)
  end
end
