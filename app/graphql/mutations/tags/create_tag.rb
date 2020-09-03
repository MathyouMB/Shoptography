module Mutations
  module Images
    # Mutation creates a Tag
    class CreateTag < BaseMutation
      argument :name, String, required: true

      type Types::TagType

      def resolve(name: nil)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        Tag.create(
          name: name,
        )
      end
    end
  end
end
