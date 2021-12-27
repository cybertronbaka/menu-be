# frozen_string_literal: true

module Types
  module Arguments
    module Order
      class OrderScopes < Types::BaseEnum
        value 'all', 'All status'
        value 'pending', 'Pending'
        value 'served', 'served'
        value 'paid', 'paid'
        value 'cancelled', 'cancelled'
      end
    end
  end
end
