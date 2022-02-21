module Types
  module Custom
    class User < BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :mobile, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :profile, ::Types::Custom::Profile, null: false
      field :role_id, ID, null: false
    end
  end
end
