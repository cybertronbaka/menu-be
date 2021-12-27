require 'rails_helper'

describe 'Rest: Create Picture' do
  let!(:user) { create(:user) }

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
