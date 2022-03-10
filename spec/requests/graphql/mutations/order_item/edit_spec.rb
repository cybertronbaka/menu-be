require 'rails_helper'

describe 'Mutations: EditOrderItem' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:order) { create(:order, restaurant_owner: owner1) }

  let!(:valid_mutation) do
    <<~GQL
      mutation {
        editOrderItem(input: {id: #{OrderItem.first.id}, orderItem: {status: "served", quantity: 2}}) {
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
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        editOrderItem(input: {id: 8, orderItem: {status: "served", quantity: 2}}) {
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
    GQL
  end

  context 'Success' do
    it 'Edits an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :editOrderItem)).to_not be_nil
      expect(parsed.dig(:data, :editOrderItem, :status)).to eq('served')
      expect(parsed.dig(:data, :editOrderItem, :quantity)).to eq(2)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
    end
  end
end
