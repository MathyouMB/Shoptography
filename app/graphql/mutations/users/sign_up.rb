module Mutations
  module Users
    # Mutation for creating a new User
    class SignUp < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :passwordConfirmation, String, required: true
      argument :firstName, String, required: true
      argument :lastName, String, required: true

      type Types::UserType

      # add password validation error handling
      def resolve(email:, password:, password_confirmation:, first_name:, last_name:)
        return GraphQL::ExecutionError.new('ERROR: password and password confirmation are not the same') unless password == password_confirmation
        return GraphQL::ExecutionError.new('ERROR: email already used by other user') unless User.where(email: email).empty?

        User.create(
          first_name: first_name,
          last_name: last_name,
          email: email,
          password: password,
          balance: 10000.00
        )
      end
    end
  end
end
