require 'rails_helper'
# https://graphql-ruby.org/testing/integration_tests

RSpec.describe('User Mutations') do
  before do
    prepare_query_variables({})
    prepare_context({})

    @user = create(:user, email: 'user@email.com', first_name: 'something', password: '1234')
  end

  describe Mutations::Users::Login do
    context 'when trying to login with a valid matching email and password' do
      it 'returns a user with the id of the desired account' do
        prepare_query('mutation login($email: String!, $password: String!){
                    login(
                      email: $email
                      password: $password
                    ){
                      user{
                        id
                      }
                    }
                  }')

        prepare_query_variables(
          email: @user.email,
          password: '1234'
        )

        user_id = graphql!['data']['login']['user']['id'].to_i
        expect(user_id).to(eq(@user.id))
      end
    end
    context 'when trying to login with an incorrect email' do
      it 'returns ERROR: no user with that email' do
        prepare_query('mutation login($email: String!, $password: String!){
                    login(
                      email: $email
                      password: $password
                    ){
                      user{
                        id
                      }
                    }
                  }')

        prepare_query_variables(
          email: 'incorrect@email.com',
          password: '1234'
        )

        response = graphql!
        expect(response['errors'].first['message']).to(eq('ERROR: no user with that email'))
      end
    end
    context 'when trying to login with an incorrect password' do
      it 'returns ERROR: Incorrect Password' do
        prepare_query('mutation login($email: String!, $password: String!){
                    login(
                      email: $email
                      password: $password
                    ){
                      user{
                        id
                      }
                    }
                  }')

        prepare_query_variables(
          email: @user.email,
          password: '123'
        )

        response = graphql!
        expect(response['errors'].first['message']).to(eq('ERROR: Incorrect Password'))
      end
    end
  end

  context Mutations::Users::SignUp do
    describe GraphqlController, type: :controller do
      context 'when trying to create a new user with a valid information' do
        it 'returns a new user with the desired info' do
          query = 'mutation signUp($firstName: String!, $lastName: String!, $email: String!, $password: String!, $passwordConfirmation: String!, ){
                        signUp(
                        firstName: $firstName
                        lastName: $lastName
                        email: $email
                        password: $password
                        passwordConfirmation: $passwordConfirmation
                        ){
                            id
                            email
                        }
                    }'

          variables = {
            firstName: 'first',
            lastName: 'last',
            email: 'newEmail@email.com',
            password: '1234',
            passwordConfirmation: '1234',
          }

          post :execute, params: { query: query, variables: variables }

          # receive response
          response_body = JSON.parse(response.body)
          created_user = User.find_by(email: 'newEmail@email.com')
          expect(response_body['data']['signUp']['id'].to_i).to(eq(created_user.id))
        end
      end
      context 'when trying to create a new user with an existing email' do
        it 'returns ERROR: email already used by other user' do
          query = 'mutation signUp($firstName: String!, $lastName: String!, $email: String!, $password: String!, $passwordConfirmation: String!, ){
                        signUp(
                        firstName: $firstName
                        lastName: $lastName
                        email: $email
                        password: $password
                        passwordConfirmation: $passwordConfirmation
                        ){
                            id
                            email
                        }
                    }'

          variables = {
            firstName: 'first',
            lastName: 'last',
            email: @user.email,
            password: '1234',
            passwordConfirmation: '1234',
          }

          post :execute, params: { query: query, variables: variables }

          response_body = JSON.parse(response.body)

          expect(response_body['errors'].first['message']).to(eq('ERROR: email already used by other user'))
        end
      end
      context 'when trying to create a new user with non matching password confirmation' do
        it 'returns ERROR: password and password confirmation are not the same' do
          query = 'mutation signUp($firstName: String!, $lastName: String!, $email: String!, $password: String!, $passwordConfirmation: String!, ){
                        signUp(
                        firstName: $firstName
                        lastName: $lastName
                        email: $email
                        password: $password
                        passwordConfirmation: $passwordConfirmation
                        ){
                            id
                            email
                        }
                    }'

          variables = {
            firstName: 'first',
            lastName: 'last',
            email: @user.email,
            password: '1234',
            passwordConfirmation: '12345',
          }

          post :execute, params: { query: query, variables: variables }

          response_body = JSON.parse(response.body)

          expect(response_body['errors'].first['message']).to(eq('ERROR: password and password confirmation are not the same'))
        end
      end
    end
  end
  context Mutations::Users::UpdateUser do
    describe GraphqlController, type: :controller do
      context 'when trying to update a given user' do
        it 'return user with the desired info' do
          query = 'mutation updateUser($firstName: String!){
                        updateUser(
                        firstName: $firstName
                        ){
                            id
                            firstName
                        }
                    }'

          user_id = { id: @user.id }
          token = JWT.encode(user_id, Rails.application.secrets.secret_key_base.byteslice(0..31))
          headers = { Authentication: token }
          request.headers.merge!(headers)
          post :execute, params: { query: query, variables: { firstName: 'updated' } }

          response_body = JSON.parse(response.body)
          expect(response_body['data']['updateUser']['firstName']).to(eq('updated'))
        end
      end
    end
  end
  context Mutations::Users::UpdateUser do
    describe GraphqlController, type: :controller do
      context 'when trying to update a given user without being logged in' do
        it 'return ERROR: Not logged in or missing token' do
          query = 'mutation updateUser($firstName: String!){
                        updateUser(
                        firstName: $firstName
                        ){
                            id
                            firstName
                        }
                    }'

          post :execute, params: { query: query, variables: { firstName: 'updated' } }

          response_body = JSON.parse(response.body)
          expect(response_body['errors'].first['message']).to(eq('ERROR: Not logged in or missing token'))
        end
      end
    end
  end
end
