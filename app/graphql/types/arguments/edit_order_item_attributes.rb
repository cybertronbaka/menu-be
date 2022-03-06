# frozen_string_literal: true

module Types
  module Arguments
    class EditOrderItemAttributes < Types::BaseInputObject
      argument :status, String, required: true
      argument :quantity, Integer, required: false
    end
  end
end
