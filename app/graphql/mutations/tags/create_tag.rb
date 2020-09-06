module Mutations
  module Tags
    # Mutation creates a Tag
    class CreateTag < BaseMutation
      argument :name, String, required: true

      type Types::TagType

      def resolve(name: nil)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?
        return GraphQL::ExecutionError.new('ERROR: Tag already exists with this name') unless Tag.find_by(name: name).nil?

        Tag.create(
          name: name,
        )
      end
    end
  end
end
