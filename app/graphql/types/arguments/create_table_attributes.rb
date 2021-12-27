# frozen_string_literal: true

module Types
  module Arguments
    class CreateTableAttributes < Types::BaseInputObject
      argument :table_no, Integer, required: true
    end
  end
end
