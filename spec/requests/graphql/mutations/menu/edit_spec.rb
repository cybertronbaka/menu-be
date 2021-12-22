require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        editMenu(input: {id: #{menu.id}, menu: {name: "My Menu"}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        editMenu(input: {id: 2, menu: {name: "My Menu"}}) {
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
      expect(parsed.dig(:data, :editMenu)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Menu.first.name).to eq('My Menu')
    end
  end

  context 'Failure' do
    it 'Purchase Needed' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Menu.count).to eq(1)
    end
  end
end
