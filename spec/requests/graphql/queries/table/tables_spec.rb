require 'rails_helper'

describe 'Queries: items' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:table) { create(:table, menu: menu) }
  let!(:table1) { create(:table, menu: menu) }
  let!(:query) do
    <<~GQL
      query{
        tables(menuId: #{menu.id}){
          pageInfo{
            totalCount
            totalPages
            limitValue
            currentPage
          }
          tables{
            id
            tableNo
            qrCode
          }
        }
      }
    GQL
  end

  context 'Success' do
    xit 'Listing Items' do
      sign_in(owner1)
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :tables, :tables).count).to eq(2)
    end
  end
end
