module Mutations
  module Images
    # Mutation updates the image of the provided id
    class UpdateImage < BaseMutation
      argument :id, Int, required: true
      argument :title, String, required: true
      argument :description, String, required: true
      argument :image, Types::File, required: true

      type Types::ImageType

      def resolve(id:, title:, description:, image:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        image = Image.find_by(id: id)

        if image.present?
          if image.user == user

            image.title = title if title.present?
            image.description = description if description.present?
            image.attached_image = image if image.present?
            image.save

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
