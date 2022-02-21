module Types
  module Custom
    class Profile < BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :address, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :user_id, ID, null: false
      field :description, String, null: true
      field :picture, String, null: true
    end
  end
end
