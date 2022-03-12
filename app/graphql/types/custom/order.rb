# frozen_string_literal: true

module Types
  module Custom
    class Order < BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :status, String, null: false
      field :mobile, String, null: true
      field :table_no, String, null: false
      field :restaurant_owner_id, ID, null: false
      field :total, Float, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
