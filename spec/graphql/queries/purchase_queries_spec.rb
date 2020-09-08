require 'rails_helper'

RSpec.describe('Purchase Queries') do
  before do
    prepare_query_variables({})
    prepare_context({})

    @user = create(:user, email: 'user@email.com', password: '1234')
    @purchase = create(:purchase, user_id: @user.id)
  end

  context Queries::Purchase do
    describe GraphqlController, type: :controller do
      context 'when logged in' do
        it 'succesfully show purchase' do
          query = 'query purchase($id: ID!){
            purchase(id: $id) {
                id
                attachedImageUrl
            }
            }'

          user_id = { id: @user.id }
          token = JWT.encode(user_id, Rails.application.secrets.secret_key_base.byteslice(0..31))
          headers = { Authentication: token }
          request.headers.merge!(headers)
          post :execute, params: { query: query, variables: { id: @purchase.id } }

          response_body = JSON.parse(response.body)
          expect(response_body['data']['purchase']['id'].to_i).to(eq(@purchase.id))
        end
      end
    end
    describe GraphqlController, type: :controller do
      context 'when not logged in' do
        it 'succesfully show purchase' do
          query = 'query purchase($id: ID!){
            purchase(id: $id) {
                id
            }
            }'

          post :execute, params: { query: query, variables: { id: @purchase.id } }

          response_body = JSON.parse(response.body)
          expect(response_body['errors'][0]['message']).to(eq('ERROR: Not logged in or missing token'))
        end
      end
    end
  end
end
