# frozen_string_literal: true

module Mutations
  module Order
    class EditOrder < BaseMutation
      argument :id, ID, required: true
      argument :order, Types::Arguments::EditOrderAttributes, required: true

      type Types::Custom::Order

      def resolve(id: nil, order: nil)
        Resolvers::Mutations::Order::EditOrder.new(context, arguments).run
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_restuarant_owner?
      end
    end
  end
end
