# frozen_string_literal: true

module Types
  module Arguments
    class EditOrderItemAttributes < Types::BaseInputObject
      argument :status, Types::Arguments::Order::OrderItemStatus, required: false
      argument :quantity, Integer, required: false
    end
  end
end
