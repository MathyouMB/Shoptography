# Migration for the User's table
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string(:first_name, null: false)
      t.string(:last_name, null: false)
      t.string(:email, null: false)
      t.string(:password_digest, null: false)
      t.float(:balance, null: false)

      t.timestamps
    end
    add_index(:users, :email, unique: true)
  end
end
