# frozen_string_literal: true

module Types
  module Arguments
    class SectionAttributes < Types::BaseInputObject
      argument :name, String, required: false
      argument :rank, Integer, required: false
    end
  end
end
