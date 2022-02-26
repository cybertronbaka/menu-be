require 'rails_helper'

describe 'Queries: menu' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:query) do
    <<~GQL
      query{
        menuByToken(token: "#{menu.token}"){
          id
          name
          description
          createdAt
          updatedAt
          userId
          qrCode
          sections {
            id
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
      post '/graphql', params: { query: query }
      expect_no_gql_errors
      expect(parsed[:data]).to_not be_nil
      expect(parsed.dig(:data, :menuByToken)).to_not be_nil
    end
  end
end
