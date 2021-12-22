# frozen_string_literal: true

module Types
  module Arguments
    class EditItemAttributes < Types::BaseInputObject
      argument :name, String, required: false
      argument :description, String, required: false
      argument :price, Float, required: false
      argument :pictures, [String], required: false
      argument :rank, Integer, required: false
    end
  end
end
