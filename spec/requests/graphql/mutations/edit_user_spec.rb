require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:valid_mutation) do
    <<~GQL
      mutation{
        editUser(
          input: {
            id: #{owner1.id},
            profileAttributes:{
              name: "Dorji",
              address:"Adddress"
            }
          }
        ){
          id
          profile {
            id
            name
          }
        }
      }
    GQL
  end

  context 'Success' do
    it 'super admin creates a restaurant owner' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :editUser)).to_not be_nil
      expect(owner1.reload.profile.name).to eq('Dorji')
    end
  end
end
