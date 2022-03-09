require 'rails_helper'

describe 'Queries: Orders' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:owner2) { create(:user, :restuarant_owner) }

  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }

  let!(:pending_order1) { create(:order, :pending, restaurant_owner: owner1, mobile: '18818818') }
  let!(:pending_order2) { create(:order, :pending, restaurant_owner: owner1) }

  let!(:served_order1) { create(:order, :served, restaurant_owner: owner1) }
  let!(:served_order2) { create(:order, :served, restaurant_owner: owner1) }

  let!(:paid_order1) { create(:order, :paid, restaurant_owner: owner1) }
  let!(:paid_order2) { create(:order, :paid, restaurant_owner: owner1) }

  let!(:cancelled_order1) { create(:order, :cancelled, restaurant_owner: owner1) }
  let!(:cancelled_order2) { create(:order, :cancelled, restaurant_owner: owner1) }

  let!(:other_order) { create(:order, :cancelled, restaurant_owner: owner2) }

  def query(scope = 'all')
    <<~GQL
      query{
        orders(scope: #{scope}, orderBy: id, orderDirection: desc) {
          pageInfo {
            totalCount
            totalPages
            limitValue
            currentPage
          }
          orders {
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
      }
    GQL
  end
  context 'All Orders' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed.dig(:data, :orders, :orders).count).to eq(8)
      expect(parsed.dig(:data, :orders, :orders).pluck(:status).uniq).to match_array(%w[pending served paid cancelled])
    end
  end

  context 'Pending Orders' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query('pending') }
      expect_no_gql_errors
      expect(parsed.dig(:data, :orders, :orders).count).to eq(2)
      expect(parsed.dig(:data, :orders, :orders).pluck(:status).uniq).to match_array(%w[pending])
    end
  end

  context 'Served Orders' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query('served') }
      expect_no_gql_errors
      expect(parsed.dig(:data, :orders, :orders).count).to eq(2)
      expect(parsed.dig(:data, :orders, :orders).pluck(:status).uniq).to match_array(%w[served])
    end
  end

  context 'Paid Orders' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query('paid') }
      expect_no_gql_errors
      expect(parsed.dig(:data, :orders, :orders).count).to eq(2)
      expect(parsed.dig(:data, :orders, :orders).pluck(:status).uniq).to match_array(%w[paid])
    end
  end

  context 'Cancelled Orders' do
    it 'lists' do
      sign_in(owner1)
      post '/graphql', params: { query: query('cancelled') }
      expect_no_gql_errors
      expect(parsed.dig(:data, :orders, :orders).count).to eq(2)
      expect(parsed.dig(:data, :orders, :orders).pluck(:status).uniq).to match_array(%w[cancelled])
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
