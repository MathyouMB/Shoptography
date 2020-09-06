# Represents the Tag entity
class Tag < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true

  # Relations
  has_many :image_tags
  has_many :images, through: :image_tags
end
