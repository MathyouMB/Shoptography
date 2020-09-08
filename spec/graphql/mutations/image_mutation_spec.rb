require 'rails_helper'
describe 'Image Mutatations' do
  describe Mutations::Images::UpdateImage do
    let(:resolver) { Mutations::Images::UpdateImage.new(object: nil, context: {}) }
    before do
      prepare_query_variables({})
      prepare_context({})

      @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
      @image = create(:image, title: 'test', user_id: @user.id)
    end
    context 'when not logged in' do
      it 'ERROR: Not logged in or missing token' do
        result = resolver.resolve(id: @image.id, title: 'Updated')
        expect(result.message).to(eq('ERROR: Not logged in or missing token'))
      end
    end
  end

  describe Mutations::Images::DeleteImage do
    let(:resolver) { Mutations::Images::DeleteImage.new(object: nil, context: {}) }
    before do
      prepare_query_variables({})
      prepare_context({})

      @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
      @image = create(:image, title: 'test', user_id: @user.id)
    end
    context 'when not logged in' do
      it 'ERROR: Not logged in or missing token' do
        result = resolver.resolve(id: @image.id)
        expect(result.message).to(eq('ERROR: Not logged in or missing token'))
      end
    end
  end

  describe Mutations::Images::CreateImage do
    let(:resolver) { Mutations::Images::CreateImage.new(object: nil, context: {}) }
    before do
      prepare_query_variables({})
      prepare_context({})

      @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
      @image = create(:image, title: 'test', user_id: @user.id)
    end
    context 'when not logged in' do
      it 'ERROR: Not logged in or missing token' do
        result = resolver.resolve(title: 'test', description: 'test', price: 1.0, private: false, image: Rack::Test::UploadedFile.new('assets/1.jpeg', '1.jpeg'))
        expect(result.message).to(eq('ERROR: Not logged in or missing token'))
      end
    end
  end
end
