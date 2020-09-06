# Represents the Image entity and its associated data
class Image < ApplicationRecord
  # Scope
  scope :public_images, -> { where(private: false) }

  # Validations
  validates :title, presence: true
  validates :price, presence: true

  # Relations
  belongs_to :user
  has_many :image_tags, dependent: :delete_all
  has_many :tags, through: :image_tags

  # Active Storage
  has_one_attached :attached_image

  # Methods
  def attached_image_url
    Rails.application.routes.url_helpers
      .rails_blob_url(attached_image, only_path: true)
  end

  def search_string
    Rails.cache.fetch([cache_key, __method__]) do
      s = title + ' ' + description + ' '
      s + tags.map(&:name).join(', ')
    end
  end
end
