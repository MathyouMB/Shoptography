module Types
  # MutationType is generated by GraphQL-Ruby
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Users::Login, description: 'Logs in a User and returns a JWT Token'
    field :sign_up, mutation: Mutations::Users::SignUp, description: 'Creates a new User using the provided info'
  end
end
