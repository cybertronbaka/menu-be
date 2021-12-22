# frozen_string_literal: true

module Types
  module Arguments
    class MenuAttributes < Types::BaseInputObject
      argument :name, String, required: false
      argument :description, String, required: false
    end
  end
end
