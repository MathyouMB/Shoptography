module Types
  # The ImageType is the GraphQL type for the Image model
  class ImageType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :attached_image_url, String, null: false
  end
end
