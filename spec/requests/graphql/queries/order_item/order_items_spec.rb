require 'rails_helper'

describe 'Queries: OrderItems' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:order) { create(:order, :cancelled, restaurant_owner: owner1) }

  let!(:query) do
    <<~GQL
      query{
        orderItems(orderId: #{order.id}) {
          pageInfo {
            totalCount
            totalPages
            limitValue
            currentPage
          }
          orderItems {
            id
            status
            quantity
            createdAt
            updatedAt
            item {
              id
              name
              description
              status
              price
              pictures
            }
          }
        }
      }
    GQL
  end

  context 'Order Items' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      binding.pry
      expect_no_gql_errors
      expect(parsed.dig(:data, :orderItems, :orderItems).count).to eq(1)
    end
  end

  context 'Failure' do
    it 'restaurant owners cannot read' do
      post '/graphql', params: { query: query }
      expect(parsed.dig(:data, :users)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('You need to sign in or sign up to perform this action.')
    end
  end
end
