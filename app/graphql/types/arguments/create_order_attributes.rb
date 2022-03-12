# frozen_string_literal: true

module Types
  module Arguments
    class CreateOrderAttributes < Types::BaseInputObject
      argument :name, String, required: false
      argument :mobile, String, required: false
      argument :table_no, Integer, required: true
      argument :order_items_attributes, [Types::Arguments::CreateOrderItemAttributes], required: true
    end
  end
end
