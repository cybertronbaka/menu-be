# frozen_string_literal: true

module Types
  module Arguments
    module Order
      class OrdersSortBy < Types::BaseEnum
        value 'id', 'ID field'
        value 'mobile', 'Mobile field'
        value 'total', 'Total field'
        value 'table_no', 'Table No field'
        value 'status', 'Status field'
        value 'created_at', 'created at field'
      end
    end
  end
end
