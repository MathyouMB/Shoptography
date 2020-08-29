# Migration for adding user foreign key to the images table
class AddUserIdToImages < ActiveRecord::Migration[6.0]
  def change
    add_reference(:images, :user, foreign_key: true)
  end
end
