# Migration for creating the purchases table
class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string(:title)
      t.text(:description)
      t.float(:cost)

      t.timestamps
    end
  end
end
