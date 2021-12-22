# frozen_string_literal: true

module Types
  module Custom
    class ItemList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :items, [Types::Custom::Item], null: true
    end
  end
end
