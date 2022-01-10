require 'rails_helper'

describe 'Rest: Create Picture' do
  let!(:user) { create(:user) }

  path '/api/v1/pictures' do
    post 'Upload Picture' do
      tags 'Picture'

      consumes 'application/json'
      parameter name: :parameters, in: :body, schema: {
        type: :object,
        properties: {
          picture: {
            type: :object,
            properties: {
              image: { type: :string, example: 'The Image' }
            }
          }
        }
      }

      produces 'application/json'

      response '200', 'Uploads picture' do
        schema type: :object,
               properties: {
                 url: { type: :string, example: 'the_url' }
               }

        context 'success' do
          let!(:params) do
            {
              picture: {
                image: fixture_file_upload('logo.png', 'image/png')
              }
            }
          end

          it 'uploads' do
            sign_in(user)
            post '/api/v1/pictures', params: params
            expect(status).to eq(200)
            expect(parsed[:url]).to_not be_nil
          end
        end
      end
    end
  end
end
