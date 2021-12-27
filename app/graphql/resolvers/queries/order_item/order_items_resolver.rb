module Resolvers
  module Queries
    module OrderItem
      class OrderItemsResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::OrderItemList, null: true

        argument :order_id, ID, required: true

        def resolve(**args)
          # TODO: Search to be implemented
          raise Unauthorized unless owner?

          paginate(queried, 'order_items')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def order
          @order ||= ::Order.find(arguments[:order_id].to_i)
        end

        def queried
          order.order_items
        end

        def owner?
          context[:current_user].id == order.restaurant_owner_id
        end
      end
    end
  end
end
