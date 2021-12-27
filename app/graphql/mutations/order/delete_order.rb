# frozen_string_literal: true

module Mutations
  module Order
    class DeleteOrder < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Order

      def resolve(id: nil)
        Resolvers::Mutations::Order::DeleteOrder.new(context, arguments).run
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
