module Mutations
  module Images
    # Mutation adds a tag to a given Image
    class AddImageTagById < BaseMutation
      argument :image_id, Int, required: true
      argument :tag_id, Int, required: true

      type Boolean

      def resolve(image_id: nil, tag_id: nil)
        user = context[:current_user]
        return GraphQL::ExecutionError.new('ERROR: Not logged in or missing token') if user.nil?
        return GraphQL::ExecutionError.new('ERROR: User is not owner of this Image') unless Image.find_by(id: image_id).user_id == user.id

        image_tag_search = ImageTag.find_by(image_id: image_id, tag_id: tag_id)

        if image_tag_search.nil?
          ImageTag.create(
            image_id: image_id,
            tag_id: tag_id
          )
        else
          GraphQL::ExecutionError.new('ERROR: Image already has this tag')
        end
      end
    end
  end
end
