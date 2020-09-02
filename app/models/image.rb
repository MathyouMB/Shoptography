# Represents the Image entity and its associated data
class Image < ApplicationRecord
  # Relations
  belongs_to :user
  has_many :image_tags
  has_many :tags, through: :image_tags

  # Active Storage
  has_one_attached :attached_image

  # Methods
  def attached_image_url
    Rails.application.routes.url_helpers
      .rails_blob_url(attached_image, only_path: true)
  end
end
