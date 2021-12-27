# frozen_string_literal: true

module Types
  module Custom
    class Table < BaseObject
      field :id, ID, null: false
      field :table_no, String, null: false
      field :qr_code, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :menu_id, ID, null: false
    end
  end
end
