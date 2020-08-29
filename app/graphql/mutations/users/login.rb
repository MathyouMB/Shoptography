module Mutations
  module Users
    # Mutation that logs in a user and returns a JWT Token
    class Login < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(email: nil, password: nil)
        return GraphQL::ExecutionError.new('error: no user with that email.') unless (user = User.find_by(email: email))

        return unless user.authenticate(password) # ~bcrypt

        user_id = { id: user.id }
        jwt = JWT.encode(user_id, Rails.application.secrets.secret_key_base.byteslice(0..31))

        { user: user, token: jwt }
      end
    end
  end
end
