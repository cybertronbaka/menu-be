# frozen_string_literal: true

module Types
  module Custom
    class OrderList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :orders, [Types::Custom::Order], null: true
      field :total_today, Float, null: true
    end
  end
end
