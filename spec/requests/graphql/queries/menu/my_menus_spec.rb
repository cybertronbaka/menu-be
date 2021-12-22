require 'rails_helper'

describe 'Queries: myMenus' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:query) do
    <<~GQL
      query{
        myMenus{
          pageInfo{
            totalCount
            totalPages
            limitValue
            currentPage
          }
          menus {
            id
            name
            description
            createdAt
            updatedAt
            userId
            sections {
              id
              items {
                id
              }
          }
          }
        }
      }
    GQL
  end

  context 'Success' do
    it 'Listing Menus' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :myMenus, :menus).count).to eq(1)
    end
  end
end
