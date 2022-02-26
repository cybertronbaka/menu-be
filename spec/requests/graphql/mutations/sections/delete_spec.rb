require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        deleteSection(input: {id: #{section.id}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        deleteSection(input: {id: 2}) {
          id
          name
        }
      }
    GQL
  end

  context 'Success' do
    it 'Updates a Section' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :deleteSection)).to_not be_nil
      expect(Section.count).to eq(0)
    end
  end

  context 'Failure' do
    it 'Not Found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Section.count).to eq(1)
    end
  end
end
