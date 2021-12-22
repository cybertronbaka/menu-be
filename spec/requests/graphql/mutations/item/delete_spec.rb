require 'rails_helper'

describe 'Mutations: deleteItem' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        deleteItem(input: {id: #{section.id}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        deleteItem(input: {id: 2}) {
          id
          name
        }
      }
    GQL
  end

  context 'Success' do
    it 'Deletes an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :deleteItem)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Menu.first.sections.count).to eq(1)
      expect(Menu.first.sections.first.items.count).to eq(0)
      expect(Item.count).to eq(0)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Item.count).to eq(1)
    end
  end
end
