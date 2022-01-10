require 'rails_helper'

describe 'Rest: Signs in' do
  let!(:user) { create(:user) }

  path '/api/v1/users/sign_in' do
    post 'Signs in' do
      tags 'Auth'

      consumes 'application/json'
      parameter name: :parameters, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'the email' },
              password: { type: :string, example: 'the password' }
            }
          }
        }
      }

      produces 'application/json'

      response '200', 'signs in' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     message: { type: :string, example: 'Signed In succesfully!'}
                   }
                 }
               }

        context 'success' do
          let!(:parameters) do
            {
              user: {
                email: user.email,
                password: user.password
              }
            }
          end

          it 'logins' do |example|
            submit_request(example.metadata)
            expect(status).to eq(200)
            expect(parsed.dig(:data, :message)).to eq('Signed In succesfully!')
            expect(cookies[:_session_id]).to_not be_nil
          end
        end
      end

      response '401', 'Could not sign in' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: {
                     oneOf: [
                       { type: :string, example: 'Invalid Email or password.'}
                     ]
                   }
                 }
               }

        context 'failure' do
          let!(:parameters) do
            {
              user: {
                email: user.email,
                password: 'Random'
              }
            }
          end

          it 'does not login' do |example|
            submit_request(example.metadata)
            expect(status).to eq(401)
            expect(parsed[:errors].first).to eq('Invalid Email or password.')
            expect(cookies[:_session_id]).to be_nil
          end
        end
      end
    end
  end
end
