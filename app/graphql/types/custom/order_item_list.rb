# frozen_string_literal: true

module Types
  module Custom
    class OrderItemList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :order_items, [Types::Custom::OrderItem], null: true
    end
  end
end
