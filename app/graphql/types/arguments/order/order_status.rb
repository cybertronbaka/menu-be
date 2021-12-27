module Types
  module Arguments
    module Order
      class OrderStatus < Types::BaseEnum
        value 'pending', 'Order Pending'
        value 'served', 'Order Served'
        value 'paid', 'Order Paid'
        value 'cancelled', 'Order Cancelled'
      end
    end
  end
end
