require 'rails_helper'

describe 'Mutations: markAllAsRead' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:order) { create(:order, restaurant_owner: owner1) }
  let!(:notification_1) { create(:notification, :read, user: owner1)}
  let!(:notification_2) { create(:notification, :not_read, user: owner1)}
  let!(:notification_3) { create(:notification, :read, user: owner1)}
  let!(:notification_4) { create(:notification, :not_read, user: owner1)}

  let!(:valid_mutation) do
    <<~GQL
      mutation {
        markAllAsRead(input: {}) {
          success
        }
      }
    GQL
  end

  context 'Success' do
    it 'Edits an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :markAllAsRead)).to_not be_nil
      expect(parsed.dig(:data, :markAllAsRead, :success)).to eq(true)
      expect(Notification.all.pluck(:read).uniq).to match_array([true])
    end
  end
end
