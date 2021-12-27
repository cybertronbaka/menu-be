# frozen_string_literal: true

module Types
  module Custom
    class OrderItem < BaseObject
      field :id, ID, null: false
      field :status, String, null: false
      field :quantity, Integer, null: false
      field :item, Types::Custom::Item, null: false
      field :order, Types::Custom::Order, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
