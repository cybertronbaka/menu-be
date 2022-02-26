require 'rails_helper'

describe 'Queries: item' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:section) { create(:section, menu: Menu.first) }
  let!(:item) { create(:item, section: section, rank: 2) }
  let!(:query) do
    <<~GQL
      query{
        item(id: #{item.id}){
          id
          name
          description
          rank
          status
          price
          vegType
          pictures
          createdAt
          updatedAt
          sectionId
        }
      }
    GQL
  end

  context 'Success' do
    it 'Listing Items' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :item)).to_not be_nil
    end
  end
end
