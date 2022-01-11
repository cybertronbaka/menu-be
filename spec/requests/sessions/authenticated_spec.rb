require 'rails_helper'

describe 'Rest: Signs in' do
  let!(:user) { create(:user) }

  path '/api/v1/authenticated' do
    get 'Checks if user is authenticated or not' do
      tags 'Auth'

      consumes 'application/json'

      produces 'application/json'

      response '200', 'signs in' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     authenticated: { type: :boolean, example: true }
                   }
                 }
               }

        it 'signed in' do |example|
          sign_in(user)
          submit_request(example.metadata)
          expect(status).to eq(200)
          expect(parsed.dig(:data, :authenticated)).to be_truthy
          expect(cookies[:_session_id]).to_not be_nil
        end

        it 'not signed in' do |example|
          submit_request(example.metadata)
          expect(status).to eq(200)
          expect(parsed.dig(:data, :authenticated)).to be_falsey
          expect(cookies[:_session_id]).to be_nil
        end
      end
    end
  end
end
