require 'rails_helper'

describe 'Mutations: reorderItems' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item1) { create(:item, section: section) }
  let!(:item2) { create(:item, section: section) }
  let!(:item3) { create(:item, section: section) }

  let!(:valid_mutation) do
    <<~GQL
      mutation {
        reorderItems(input: {
          sectionId: #{section.id},
          items: [
            {id: #{item2.id}, rank: 1}
            {id: #{item3.id}, rank: 2}
            {id: #{item1.id}, rank: 3}
          ]
        }) {
          id
          rank
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        reorderItems(input: {
          sectionId: #{section.id + 2},
          items: [
            {id: #{item2.id}, rank: 1}
            {id: #{item3.id}, rank: 2}
            {id: #{item1.id}, rank: 3}
          ]
        }) {
          id
          rank
        }
      }
    GQL
  end

  context 'Success' do
    it 'Edits an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :reorderItems)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Item.count).to eq(3)
      expect(item1.reload.rank).to eq(3)
      expect(item2.reload.rank).to eq(1)
      expect(item3.reload.rank).to eq(2)
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
