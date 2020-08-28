# This Model represents a User entity
class User < ApplicationRecord
  # Bcrypt Secure Password
  has_secure_password

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Relations
end
