require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        createMenu(input: {menu: {name: "My Menu", description: "Description"}}) {
          id
          name
        }
      }
    GQL
  end

  context 'Success' do
    it 'Creates a menu' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createMenu)).to_not be_nil
      expect(Menu.count).to eq(1)
    end
  end

  context 'Failure' do
    let!(:menu) { create(:menu, user: owner1) }
    it 'Purchase Needed' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect(parsed[:errors].first[:message]).to eq('To create more menu, please contact us')
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('PURCHASE_NEEDED')
      expect(Menu.count).to eq(1)
    end
  end

  context 'Restricted to 2' do
    let!(:menu) { create(:menu, user: owner1) }
    let!(:restriction) { create(:restriction, :menu_count, user: owner1, value: 2) }

    it 'Creates a menu' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createMenu)).to_not be_nil
      expect(Menu.count).to eq(2)
    end

    context 'Failure' do
      let!(:menu1) { create(:menu, user: owner1) }
      it 'Purchase Needed' do
        sign_in(owner1)
        post '/graphql', params: { query: valid_mutation }
        expect(parsed[:errors].first[:message]).to eq('To create more menu, please contact us')
        expect(parsed[:errors].first.dig(:extensions, :code)).to eq('PURCHASE_NEEDED')
        expect(Menu.count).to eq(2)
      end
    end
  end
end
