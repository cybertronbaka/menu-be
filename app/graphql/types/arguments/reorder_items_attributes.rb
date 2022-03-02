# frozen_string_literal: true

module Types
  module Arguments
    class ReorderItemsAttributes < Types::BaseInputObject
      argument :id, ID, required: true
      argument :rank, Integer, required: true
    end
  end
end
