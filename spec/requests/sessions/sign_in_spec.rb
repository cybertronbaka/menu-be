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
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     email: { type: :string, example: 'sean.leannon@haag-oberbrunner.info' },
                     mobile: { type: :string, example: '+975-17171717' },
                     created_at: { type: :string, example: '2022-01-20T17:40:12.492Z' },
                     updated_at: { type: :string, example: '2022-01-20T17:40:12.492Z' },
                     profile_attributes: {
                       type: :object,
                       properties: {
                         id: { type: :integer, example: 1 },
                         name: { type: :string, example: 'Alvin' },
                         address: { type: :string, example: 'Some address' },
                         user_id: { type: :integer, example: 1 },
                         created_at: { type: :string, example: '2022-01-20T17:40:12.492Z' },
                         updated_at: { type: :string, example: '2022-01-20T17:40:12.492Z' },
                       }
                     },
                     role_attributes: {
                       type: :object,
                       properties: {
                         id: { type: :integer, example: 1 },
                         name: { type: :string, example: 'super_admin', enum: %w[super_admin restuarant_owner] },
                         created_at: { type: :string, example: '2022-01-20T17:40:12.492Z' },
                         updated_at: { type: :string, example: '2022-01-20T17:40:12.492Z' }
                       }
                     }
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
                       { type: :string, example: 'Invalid Email or password.' }
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
