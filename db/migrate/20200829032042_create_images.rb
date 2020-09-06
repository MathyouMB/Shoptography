# Migration for creating the images table
class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string(:title)
      t.text(:description)
      t.float(:price)
      t.boolean(:private)

      t.timestamps
    end
  end
end
