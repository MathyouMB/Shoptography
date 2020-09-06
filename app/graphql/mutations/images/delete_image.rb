module Mutations
  module Images
    # Mutation deletes the image of the provided id
    class DeleteImage < BaseMutation
      argument :id, Int, required: true

      type Types::ImageType

      def resolve(id:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        image = Image.find_by(id: id)

        if image.present?
          if image.user == user

            image.destroy!

            raise GraphQL::ExecutionError, image.errors.full_messages.join(', ') unless image.errors.empty?

            image
          else
            raise GraphQL::ExecutionError, 'ERROR: Current User is not the creator of this Image'
          end
        else
          raise GraphQL::ExecutionError, "ERROR: Image with id #{id} does not exist"
        end
      end
    end
  end
end
