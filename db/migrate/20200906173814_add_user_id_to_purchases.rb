# Migration for adding relations to the purchases table
class AddUserIdToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference(:purchases, :user, foreign_key: true)
    add_reference(:purchases, :merchant, index: true)
  end
end
