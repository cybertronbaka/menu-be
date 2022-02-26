require 'rails_helper'

describe 'Queries: order' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:order) { create(:order, :pending, restaurant_owner: owner1) }
  let!(:query) do
    <<~GQL
      query{
        order(id: #{order.id}){
          id
          status
          mobile
          tableNo
          restaurantOwnerId
          total
          createdAt
          updatedAt
        }
      }
    GQL
  end

  context 'Success' do
    it 'Show Order' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :order)).to_not be_nil
    end
  end
end
