require 'rails_helper'

describe 'Queries: item' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:table) { create(:table, menu: menu) }
  let!(:query) do
    <<~GQL
      query{
        table(id: #{table.id}){
          id
          tableNo
          qrCode
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
      expect(parsed.dig(:data, :table)).to_not be_nil
    end
  end
end
