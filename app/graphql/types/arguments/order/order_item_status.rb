module Types
  module Arguments
    module Order
      class OrderItemStatus < Types::BaseEnum
        value 'pending', 'Order Pending'
        value 'served', 'Order Served'
      end
    end
  end
end
