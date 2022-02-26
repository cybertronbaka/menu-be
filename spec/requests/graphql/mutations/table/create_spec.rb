require 'rails_helper'

describe 'Mutations: CreateTable' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section) { create(:section, menu: menu) }
  let!(:valid_mutation) do
    <<~GQL
      mutation {
        createTable(input: {menuId: #{menu.id}, table: {tableNo: 1}}) {
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
        createTable(input: {menuId: 2, table: {tableNo: 1}}) {
          id
          tableNo
          qrCode
        }
      }
    GQL
  end

  context 'Success' do
    xit 'Creates a Table' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createTable)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Table.count).to eq(1)
    end
  end

  context 'Failure' do
    xit 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
      expect(Table.count).to eq(0)
    end
  end
end
