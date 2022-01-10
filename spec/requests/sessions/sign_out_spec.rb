require 'rails_helper'

describe 'Rest: Signs Out' do
  let!(:user) { create(:user) }

  path '/api/v1/users/sign_out' do
    delete 'Signs Out' do
      tags 'Auth'

      produces 'application/json'

      response '200', 'signs out' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     message: {type: :string, example: 'Signed Out successfully' }
                   }
                 }
               }

        context 'success' do
          it 'signs out' do |example|
            sign_in(user)
            submit_request(example.metadata)
            expect(status).to eq(200)
            expect(parsed.dig(:data, :message)).to eq('Signed Out successfully')
          end
        end
      end

      response '401', 'does not sign out' do
        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: {
                     oneOf: [
                       { type: :string, example: 'You need to sign in or sign up before continuing.' }
                     ]
                   }
                 }
               }
        context 'failure' do
          it 'does not sign out' do |example|
            submit_request(example.metadata)
            expect(status).to eq(401)
            expect(parsed[:errors].first).to eq('You need to sign in or sign up before continuing.')
            expect(cookies[:_session_id]).to be_nil
          end
        end
      end
    end
  end
end
