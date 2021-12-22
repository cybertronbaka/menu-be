require 'rails_helper'

describe 'Rest: Signs Out' do
  let!(:user) { create(:user) }

  context 'success' do
    it 'signs out' do
      sign_in(user)
      delete '/api/v1/users/sign_out'
      expect(status).to eq(200)
      expect(parsed.dig(:data, :message)).to eq('Signed Out successfully')
    end
  end

  context 'failure' do
    it 'does not sign out' do
      delete '/api/v1/users/sign_out'
      expect(status).to eq(401)
      expect(parsed[:errors].first).to eq('You need to sign in or sign up before continuing.')
      expect(cookies[:_session_id]).to be_nil
    end
  end
end
