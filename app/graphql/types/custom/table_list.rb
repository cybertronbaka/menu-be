# frozen_string_literal: true

module Types
  module Custom
    class TableList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :tables, [Types::Custom::Table], null: true
    end
  end
end
