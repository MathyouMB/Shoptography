
module Types
  # The UserType is the GraphQL type for the User model
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :firstName, String, null: false
    field :lastName, String, null: false
    field :email, String, null: false
  end
end
