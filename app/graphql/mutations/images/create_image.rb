module Mutations
  module Images
    # Mutation that creates an Image entity with the provided information
    class CreateImage < BaseMutation
      argument :title, String, required: true
      argument :description, String, required: true
      argument :image, Types::File, required: true

      type Types::ImageType

      def resolve(title:, description:, image:)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?

        Image.create!(
          title: title,
          description: description,
          attached_image: image,
          user_id: user.id
        )
      end
    end
  end
end
