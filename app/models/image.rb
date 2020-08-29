# Represents the Image entity and its associated data
class Image < ApplicationRecord
  belongs_to :user
  has_many :image_tags
  has_many :tags, through: :image_tags
end
