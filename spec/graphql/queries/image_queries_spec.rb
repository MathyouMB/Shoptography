require 'rails_helper'

RSpec.describe('Image Queries') do
  before do
    prepare_query_variables({})
    prepare_context({})

    3.times do
      u = create(:user)
      create(:image, title: 'test', user_id: u.id)
    end

    @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
    create(:image, private: true, user_id: @user.id)
  end

  describe Queries::Image do
    context 'when passed the id of the first image' do
      it 'returns a image with the id of the first image' do
        first_image_id = Image.first.id

        prepare_query('query image($id: ID!){
                      image(id: $id) {
                          id
                      }
                      }')

        prepare_query_variables(
          id: first_image_id
        )

        image_id = graphql!['data']['image']['id'].to_i
        expect(image_id).to(eq(first_image_id))
      end
    end
  end

  describe Queries::Image do
    context 'when passed the id of a private image' do
      it 'should not allow user to view the image' do
        last_image_id = Image.last.id

        prepare_query('query image($id: ID!){
                      image(id: $id) {
                          id
                      }
                      }')

        prepare_query_variables(
          id: last_image_id
        )

        response = graphql!['errors'][0]['message']
        expect(response).to(eq('ERROR: Image of given ID is nil'))
      end
    end
  end
  describe Queries::ImageSearch do
    context 'when there are 4 quizzes in the database with same name, but one is private' do
      it 'returns a search result with a length of 3 because one is private' do
        prepare_query('query{
                      imageSearch(searchInput: "test"){
                        id
                        title
                        attachedImageUrl
                      }
                    }')

        images = graphql!['data']['imageSearch']
        expect(images.length).to(eq(3))
      end
    end
  end
end
