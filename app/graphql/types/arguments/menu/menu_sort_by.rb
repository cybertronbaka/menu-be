# frozen_string_literal: true

module Types
  module Arguments
    module Menu
      class MenuSortBy < Types::BaseEnum
        value 'id', 'ID field'
        value 'name', 'Restaurant Name field'
        value 'created_at', 'created_at field'
      end
    end
  end
end
