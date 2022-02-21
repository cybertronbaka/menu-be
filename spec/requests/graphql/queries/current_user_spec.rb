require 'rails_helper'

describe 'Queries: Current User' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:query) do
    <<~GQL
      query{
        currentUser{
          id
          email
          mobile
          createdAt
          roleId
          profile {
            id
            name
            address
            createdAt
            updatedAt
            userId
            description
            picture
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
      expect(parsed.dig(:data, :currentUser)).to_not be_nil
    end
  end
end
