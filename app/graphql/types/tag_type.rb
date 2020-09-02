module Types
  # The TagType is the GraphQL type for the Tag model
  class TagType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
  end
end
