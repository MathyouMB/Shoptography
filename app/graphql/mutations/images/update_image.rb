module Mutations
  module Images
    # Mutation updates the image of the provided id
    class UpdateImage < BaseMutation
      argument :id, Int, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :private, Boolean, required: false
      argument :image, Types::File, required: false

      type Types::ImageType

      def resolve(id:, title: nil, description: nil, private: nil, image: nil)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        image_search = Image.find_by(id: id)

        if image_search.present?
          if image_search.user == user

            image_search.title = title if title.present?
            image_search.description = description if description.present?
            image_search.private = private if private.present?
            image_search.attached_image = image if image.present?
            image_search.save

            raise GraphQL::ExecutionError, image_search.errors.full_messages.join(', ') unless image_search.errors.empty?

            image_search
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
