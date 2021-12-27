# frozen_string_literal: true

module Types
  module Arguments
    class CreateOrderItemAttributes < Types::BaseInputObject
      argument :item_id, ID, required: true
      argument :quantity, Integer, required: true
    end
  end
end
