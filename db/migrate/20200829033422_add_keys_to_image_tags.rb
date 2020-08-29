# Migration for adding image and tag foreign keys to image_tags
class AddKeysToImageTags < ActiveRecord::Migration[6.0]
  def change
    add_reference(:image_tags, :image, foreign_key: true)
    add_reference(:image_tags, :tag, foreign_key: true)
  end
end
