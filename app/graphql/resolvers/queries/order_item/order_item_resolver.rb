# frozen_string_literal: true

module Resolvers
  module Queries
    module OrderItem
      class OrderItemResolver < BaseQueryResolver
        type Types::Custom::OrderItem, null: false

        argument :id, ID, required: true

        delegate :order, to: :order_item

        def resolve(id: nil)
          raise Unauthorized unless owner?

          order_item
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def order_item
          @order_item ||= ::OrderItem.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == order.restaurant_owner_id
        end
      end
    end
  end
end
