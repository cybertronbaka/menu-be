module Types
  module Custom
    class Section < BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :rank, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :menu_id, ID, null: false
      field :items, [Types::Custom::Item], null: true
    end
  end
end
