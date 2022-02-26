require 'rails_helper'

describe 'Queries: items' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section, rank: 2) }
  let!(:item2) { create(:item, section: section, rank: 1) }
  let!(:query) do
    <<~GQL
      query{
        items(sectionId: #{section.id}){
          pageInfo{
            totalCount
            totalPages
            limitValue
            currentPage
          }
          items{
            id
            name
            description
            rank
            status
            price
            pictures
            createdAt
            updatedAt
            sectionId
          }
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
      expect(parsed.dig(:data, :items, :items).count).to eq(2)
      expect(parsed.dig(:data, :items, :items).pluck(:id)).to match_array(%w[2 1])
    end
  end
end
