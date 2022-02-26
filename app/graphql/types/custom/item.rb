# frozen_string_literal: true

module Types
  module Custom
    class Item < BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :description, String, null: true
      field :rank, Integer, null: false
      field :status, String, null: false
      field :price, Float, null: false
      field :veg_type, String, null: false
      field :pictures, [String], null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :section_id, ID, null: false
    end
  end
end
