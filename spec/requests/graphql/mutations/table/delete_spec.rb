require 'rails_helper'

describe 'Mutations: deleteTable' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { create(:menu, user: owner1) }
  let!(:section) { create(:section, menu: menu) }
  let!(:item) { create(:item, section: section) }
  let!(:table) { create(:table, menu: menu)}
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        deleteTable(input: {id: #{table.id}}) {
          id
          tableNo
          qrCode
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        deleteTable(input: {id: 2}) {
          id
          tableNo
          qrCode
        }
      }
    GQL
  end

  context 'Success' do
    it 'Deletes an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :deleteTable)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Table.count).to eq(0)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Table.count).to eq(1)
    end
  end
end
