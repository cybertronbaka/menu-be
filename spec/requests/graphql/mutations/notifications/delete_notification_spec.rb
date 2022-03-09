require 'rails_helper'

describe 'Mutations: deleteNotification' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:order) { create(:order, restaurant_owner: owner1) }
  let!(:notification) { create(:notification, user: owner1)}
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        deleteNotification(input: {id: #{notification.id}}) {
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
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        deleteNotification(input: {id: 3}) {
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
    GQL
  end

  context 'Success' do
    it 'Edits an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :deleteNotification)).to_not be_nil
      expect(Notification.count).to eq(0)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(user)
      post '/graphql', params: { query: valid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('UNAUTHORIZED')
    end

    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
    end
  end
end
