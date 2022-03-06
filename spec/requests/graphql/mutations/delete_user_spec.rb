require 'rails_helper'

describe 'Mutations: DeleteUser' do
  let!(:user) { create(:user, :super_admin) }
  let!(:owner_1) { create(:user, :restuarant_owner) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
       deleteUser(input:{
        id: 1
        })
        {
          id
        }}
    GQL
  end

  context 'Success' do
    it 'super admin deletes a restaurant owner' do
      sign_in(user)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :deleteUser)).to_not be_nil
      expect(User.count).to eq(1)
    end
  end
end
