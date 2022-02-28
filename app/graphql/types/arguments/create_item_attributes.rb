# frozen_string_literal: true

module Types
  module Arguments
    class CreateItemAttributes < Types::BaseInputObject
      argument :name, String, required: true
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :pictures, [String], required: false
      argument :status, String, required: false
      argument :vegType, String, required: false
    end
  end
end
