# frozen_string_literal: true

module Types
  module Custom
    class OrderItem < BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :description, String, null: true
      field :price, Float, null: false
      field :pictures, [String], null: false
      field :status, String, null: false
      field :quantity, Integer, null: false
      field :item, Types::Custom::Item, null: true
      field :order, Types::Custom::Order, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
