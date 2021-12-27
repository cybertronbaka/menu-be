# frozen_string_literal: true

module Mutations
  module OrderItem
    class EditOrderItem < BaseMutation
      argument :id, ID, required: true
      argument :order_item, Types::Arguments::EditOrderItemAttributes, required: true

      type Types::Custom::OrderItem

      def resolve(id: nil, order_item: nil)
        Resolvers::Mutations::OrderItem::EditOrderItem.new(context, arguments).run
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
