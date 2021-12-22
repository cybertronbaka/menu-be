require 'rails_helper'

describe 'Queries: menu' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:query) do
    <<~GQL
      query{
        sections(menuId: #{menu.id}){
          pageInfo{
            totalCount
            totalPages
            limitValue
            currentPage
          }
          sections{
            id
            name
            createdAt
            updatedAt
            menuId
            items {
              id
            }
          }
        }
      }
    GQL
  end

  context 'Success' do
    it 'Show Menu' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :sections, :sections)).to_not be_nil
    end
  end
end
