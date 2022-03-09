require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner_1) { create(:user, :restuarant_owner) }
  let!(:notification_1) { create(:notification, user: owner_1) }
  let!(:notification_2) { create(:notification, user: owner_1) }

  let!(:query) do
    <<~GQL
      query{
        myNotifications{
          pageInfo {
            totalCount
            totalPages
            limitValue
            currentPage
          }
          notifications {
            id
            notificationType
            body
            link
            image
            read
            userId
            createdAt
            updatedAt
          }
        }
      }
    GQL
  end

  context 'Success' do
    it 'Gets my notifications' do
      sign_in(owner_1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed.dig(:data, :myNotifications, :notifications).count).to eq(2)
    end
  end
end
