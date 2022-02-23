require 'rails_helper'

describe 'Mutations: CreateRestaurantOwner' do
  let!(:user) { create(:user) }
  let!(:valid_mutation) do
    <<~GQL
      mutation{
          createRestuarantOwner(
              input: {
                userCreationAttributes:{
                  email:"xyz@gmail.com",
                  mobile:"13414"
                  password: "nyemenu2021",
                  passwordConfirmation: "nyemenu2021"
                },
                profileAttributes:{
                  name: "Dorji",
                  address:"Adddress"
                }
              }
          ) {
              id
              profile {
                id
                name
                address
              }
          }
      }
    GQL
  end

  context 'Success' do
    it 'super admin creates a restaurant owner' do
      sign_in(user)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createRestuarantOwner)).to_not be_nil
      expect(User.count).to eq(2)
      expect(Menu.count).to eq(1)
    end

    it 'super admin creates a restaurant owner and can log in' do
      sign_in(user)
      post '/graphql', params: { query: valid_mutation }
      expect_no_gql_errors
      expect(parsed.dig(:data, :createRestuarantOwner)).to_not be_nil
      expect(User.count).to eq(2)
      sign_out
      sign_in(User.last, 'nyemenu2021')
      expect(status).to eq(200)
    end
  end

  context 'Failure' do
    let!(:owner) { create(:user, :restuarant_owner) }
    let!(:email_used_mutation) do
      <<~GQL
        mutation{
            createRestuarantOwner(
                input: {
                  userCreationAttributes:{
                    email:"#{owner.email}",
                    mobile:"13414"
                    password: "nyemenu2021",
                    passwordConfirmation: "nyemenu2021"
                  },
                  profileAttributes:{
                    name: "Dorji",
                    address:"Adddress"
                  }
              }
            ) {
                id
                profile {
                  id
                  name
                  address
                }
            }
        }
      GQL
    end

    it 'email already used' do
      sign_in(user)
      post '/graphql', params: { query: email_used_mutation }
      expect(status).to eq(200)
      expect(parsed.dig(:data, :createRestuarantOwner)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('Email has already been taken')
      expect(User.count).to eq(2)
    end

    it 'restaurant owner cannot create user' do
      sign_in(owner)
      post '/graphql', params: { query: valid_mutation }
      expect(status).to eq(200)
      expect(parsed.dig(:data, :createRestuarantOwner)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('You are not authorized to perform this action')
      expect(User.count).to eq(2)
    end

    it 'user should be present' do
      post '/graphql', params: { query: valid_mutation }
      expect(status).to eq(200)
      expect(parsed.dig(:data, :createRestuarantOwner)).to be_nil
      expect(parsed[:errors].first[:message]).to eq('You need to sign in or sign up to perform this action.')
      expect(User.count).to eq(2)
    end
  end
end
