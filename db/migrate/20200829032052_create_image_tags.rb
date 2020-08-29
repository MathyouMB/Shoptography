# Migration for creating the image_tags join table
class CreateImageTags < ActiveRecord::Migration[6.0]
  def change
    create_table :image_tags do |t|
      t.timestamps
    end
  end
end
