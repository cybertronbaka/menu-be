# frozen_string_literal: true

module Mutations
  module Order
    class CreateOrder < BaseMutation
      argument :token, String, required: true
      argument :order, Types::Arguments::CreateOrderAttributes, required: true

      type Types::Custom::Order

      def resolve(token: nil, order: nil)
        Resolvers::Mutations::Order::CreateOrder.new(context, arguments).run
      end
    end
  end
end
