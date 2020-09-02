module Queries
  # A Query that returns the information of a given user based on the given id
  class User < Queries::BaseQuery
    description 'Get User by id'
    argument :id, ID, required: true
    type Types::UserType, null: false

    def resolve(id:)
      user = ::User.find(id)
      return GraphQL::ExecutionError.new('ERROR: User of given ID is nil') if user.nil?

      user
    end
  end
end
