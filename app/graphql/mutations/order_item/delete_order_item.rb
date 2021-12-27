# frozen_string_literal: true

module Mutations
  module OrderItem
    class DeleteOrderItem < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::OrderItem

      def resolve(id: nil)
        Resolvers::Mutations::OrderItem::DeleteOrderItem.new(context, arguments).run
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
