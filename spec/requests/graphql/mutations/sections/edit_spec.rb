require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        editSection(input: {id: #{section.id}, section: {name: "Snacks"}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        editSection(input: {id: 2, section: {name: "Snacks"}}) {
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
      expect(parsed.dig(:data, :editSection)).to_not be_nil
      expect(Section.count).to eq(1)
      expect(Section.first.name).to eq('Snacks')
    end
  end

  context 'Failure' do
    it 'Not Found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
    end
  end
end
