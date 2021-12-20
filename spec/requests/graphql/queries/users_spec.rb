require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner_1) { create(:user, :restuarant_owner)}
  let!(:query) do
    <<~GQL
        query{
            users(
              roleName: restuarant_owner
            ) {
                id
                profile {
                  id
                  name
                  address
                }
            }
        }
    GQL
  end

  context 'Success' do
    it 'super admin creates a restaurant owner' do
      sign_in(user)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed.dig(:data, :users).count).to eq(1)
    end
  end

  context 'Failure' do
    it 'restaurant owners cannot read' do
      sign_in(owner_1)
      post '/graphql', params: { query: query }
      expect(parsed[:data]).to be_nil
      expect(parsed[:errors].first[:message]).to eq('You are not authorized to perform this action')
    end
  end
end