require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        createSection(input: {menuId: #{menu.id}, section: {name: "Snacks"}}) {
          id
          name
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        createSection(input: {menuId: 2, section: {name: "Snacks"}}) {
          id
          name
        }
      }
    GQL
  end

  context 'Success' do
    it 'Creates a Section' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createSection)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Menu.first.sections.count).to eq(1)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Menu.count).to eq(1)
    end
  end
end
