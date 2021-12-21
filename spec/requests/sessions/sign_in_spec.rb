require 'rails_helper'

describe 'Rest: Signs in' do
  let!(:user) { create(:user) }

  context 'success' do
    let!(:params) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'logins' do
      post '/api/v1/users/sign_in', params: params
      expect(status).to eq(200)
      expect(parsed.dig(:data, :message)).to eq('Signed In succesfully!')
      expect(cookies[:_session_id]).to_not be_nil
    end
  end

  context 'failure' do
    let!(:params) do
      {
        user: {
          email: user.email,
          password: 'Random'
        }
      }
    end

    it 'does not login' do
      post '/api/v1/users/sign_in', params: params
      expect(status).to eq(401)
      expect(parsed[:errors].first).to eq('Invalid Email or password.')
      expect(cookies[:_session_id]).to be_nil
    end
  end
end
