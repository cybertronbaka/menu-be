# frozen_string_literal: true

module Resolvers
  module Mutations
    module OrderItem
      class DeleteOrderItem < BaseMutationResolver
        delegate :order, to: :order_item

        def run
          raise Unauthorized unless owner?

          order.order_items.count == 1 ? order.destroy! : order_item.destroy!
          order_item
        end

        private

        def order_item
          @order_item ||= ::OrderItem.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == order.restaurant_owner_id
        end
      end
    end
  end
end
