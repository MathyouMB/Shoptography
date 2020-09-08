require 'rails_helper'
describe 'Purchase Mutatations' do
  describe Mutations::Purchases::CreatePurchase do
    let(:resolver) { Mutations::Purchases::CreatePurchase.new(object: nil, context: {}) }
    before do
      prepare_query_variables({})
      prepare_context({})

      @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
      @user2 = create(:user, email: 'merchant@email.com', first_name: 'something', password: '1234')
      @image = create(:image, title: 'test', user_id: @user2.id)
    end
    context 'when not logged in' do
      it 'ERROR: Not logged in or missing token' do
        result = resolver.resolve(image_id: @image.id)
        expect(result.message).to(eq('ERROR: Not logged in or missing token'))
      end
    end
  end
end
