module Types
  # MutationType is generated by GraphQL-Ruby
  class MutationType < Types::BaseObject
    # User
    field :login, mutation: Mutations::Users::Login, description: 'Logs in a User and returns a JWT Token'
    field :sign_up, mutation: Mutations::Users::SignUp, description: 'Creates a new User using the provided info'

    # Image
    field :upload_image, mutation: Mutations::Images::UploadImage, description: 'Creates an Image Entity using the provided information'
    field :add_image_tag_by_id, mutation: Mutations::Images::AddImageTagById, description: 'Adds a Tag to a given Image using the provided tag id'
    field :add_image_tag, mutation: Mutations::Images::AddImageTag, description: 'Adds a Tag to a given Image using the provided tag name'

    # Tag
    field :create_tag, mutation: Mutations::Tags::CreateTag, description: 'Creates a Tag given the provided name'
  end
end
