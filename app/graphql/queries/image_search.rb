module Queries
  # A Query that returns all Images relevant to the provided search string
  class ImageSearch < Queries::BaseQuery
    description 'Text based image search query.'
    argument :search_input, String, required: true
    type [Types::ImageType], null: false

    def resolve(search_input:)
      images = ::Image.public_images
      results = []
      images.each do |i|
        results << i if i.search_string.downcase.include?(search_input.downcase)
      end
      results
    end
  end
end
