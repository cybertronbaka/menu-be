module Types
  module Custom
    class Menu < BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :description, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :user_id, ID, null: false
    end
  end
end
