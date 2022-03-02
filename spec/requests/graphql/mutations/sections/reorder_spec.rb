require 'rails_helper'

describe 'Mutations: reorderItems' do
  let!(:user) { create(:user) }
  let!(:owner1) { create(:user, :restuarant_owner) }
  let!(:menu) { Menu.first }
  let!(:section1) { create(:section, menu: menu) }
  let!(:section2) { create(:section, menu: menu) }
  let!(:section3) { create(:section, menu: menu) }

  let!(:valid_mutation) do
    <<~GQL
      mutation {
        reorderSections(input: {
          menuId: #{menu.id},
          sections: [
            {id: #{section2.id}, rank: 1}
            {id: #{section3.id}, rank: 2}
            {id: #{section1.id}, rank: 3}
          ]
        }) {
          id
          rank
        }
      }
    GQL
  end

  let!(:invalid_mutation) do
    <<~GQL
      mutation {
        reorderSections(input: {
          menuId: #{menu.id + 2},
          sections: [
            {id: #{section2.id}, rank: 1}
            {id: #{section3.id}, rank: 2}
            {id: #{section1.id}, rank: 3}
          ]
        }) {
          id
          rank
        }
      }
    GQL
  end

  context 'Success' do
    it 'Edits an Item' do
      sign_in(owner1)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :reorderSections)).to_not be_nil
      expect(Menu.count).to eq(1)
      expect(Section.count).to eq(3)
      expect(section2.reload.rank).to eq(1)
      expect(section3.reload.rank).to eq(2)
      expect(section1.reload.rank).to eq(3)
    end
  end

  context 'Failure' do
    it 'Not found' do
      sign_in(owner1)
      post '/graphql', params: { query: invalid_mutation }
      expect(parsed[:errors].first.dig(:extensions, :code)).to eq('NOT_FOUND')
    end
  end
end
