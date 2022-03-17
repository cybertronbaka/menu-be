require 'rails_helper'

describe 'Mutations: DeleteUser' do
  let!(:user) { create(:user, :super_admin) }
  let!(:owner_1) { create(:user, :restuarant_owner) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
       updateUserSubscription(input:{
          id: #{owner_1.id},
          status: "cancelled"
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
      expect(parsed.dig(:data, :updateUserSubscription)).to_not be_nil
      expect(owner_1.reload.status.to_sym).to eq(:cancelled)
    end
  end
end
