require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        createItem(input: {sectionId: #{section.id}, item: {name: "Pizza", price: 300}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        createItem(input: {sectionId: 2, item: {name: "Pizza", price: 300}}) {
          id
          name
        }
      }
    GQL
  end

  context 'Success' do
    it 'Creates a Section' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createItem)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Menu.first.sections.count).to eq(1)
      expect(Menu.first.sections.first.items.count).to eq(1)
      expect(Item.count).to eq(1)
      expect(Item.first.name).to eq('Pizza')
      expect(Item.first.rank).to eq(1)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Item.count).to eq(0)
    end
  end
end
