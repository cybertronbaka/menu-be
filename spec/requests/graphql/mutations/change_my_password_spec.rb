require 'rails_helper'

describe 'Mutations: DeleteUser' do
  let!(:user) { create(:user, :super_admin) }
  let!(:owner_1) { create(:user, :restuarant_owner) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
       changeMyPassword(input:{
          currentPassword: "NyeMenu2021",
          password: "NyeMenu2025",
          passwordConfirmation: "NyeMenu2025",
       })
        {
          id
        }}
    GQL
  end

  let!(:mismatch_mutation) do
    <<~GQL
      mutation {
       changeMyPassword(input:{
          currentPassword: "NyeMenu2021",
          password: "NyeMenu2025",
          passwordConfirmation: "sdfsdf",
       })
        {
          id
        }}
    GQL
  end

  let!(:invalid_current_password_mutation) do
    <<~GQL
      mutation {
       changeMyPassword(input:{
          currentPassword: "dskajflkdsj",
          password: "NyeMenu2025",
          passwordConfirmation: "NyeMenu2025",
       })
        {
          id
        }}
    GQL
  end

  context 'Success' do
    it 'Owner Changes the his password' do
      # Before User Resets its own password
      post '/api/v1/users/sign_in', params: { user: { email: owner_1.email, password: 'NyeMenu2025' } }
      expect(status).to eq(401)

      sign_in(owner_1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :changeMyPassword)).to_not be_nil
      sign_out

      # After User Resets its own password
      post '/api/v1/users/sign_in', params: { user: { email: owner_1.email, password: 'NyeMenu2025' } }
      expect(status).to eq(200)
    end
  end

  context 'Failure' do
    it 'Owner Changes the his password' do
      sign_in(owner_1)
      post '/graphql', params: { query: mismatch_mutation }
      expect(parsed.dig(:data, :changeMyPassword)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('Password and Password Confirmation need to be same')
    end

    it 'Owner Changes the his password but current password is wrong' do
      sign_in(owner_1)
      post '/graphql', params: { query: invalid_current_password_mutation }
      expect(parsed.dig(:data, :changeMyPassword)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('You are not authorized to perform this action')
    end
  end
end
