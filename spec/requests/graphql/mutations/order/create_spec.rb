require 'rails_helper'

describe 'Mutations: CreateTable' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item1) { create(:item, section: section) }
  let!(:item2) { create(:item, section: section) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        createOrder(
          input: {
            token: "#{menu.token}",
            order: {
              name: "Dorji Gyeltshen",
              tableNo: 1,
              mobile: "17171717",
              orderItemsAttributes: [
                {
                  itemId: #{item1.id},
                  quantity: 2
                },
                {
                  itemId: #{item2.id},
                  quantity: 1
                }
              ]
            }
          }
        ) {
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

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        createOrder(
          input: {
            token: "1",
            order: {
              tableNo: 1,
              mobile: "17171717",
              orderItemsAttributes: [
                {
                  itemId: #{item1.id},
                  quantity: 2
                },
                {
                  itemId: #{item2.id},
                  quantity: 1
                }
              ]
            }
          }
        ) {
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
    it 'Creates a Table' do
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createOrder)).to_not be_nil
      expect(Order.count).to eq(1)
      expect(OrderItem.count).to eq(2)
      expect(parsed.dig(:data, :createOrder, :total)).to eq(300)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Table.count).to eq(0)
    end
  end
end
