module Resolvers
  module Queries
    module Order
      class OrdersResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::OrderList, null: true

        argument :order_by, Types::Arguments::Order::OrdersSortBy, required: false
        argument :order_direction, Types::Arguments::OrderDirection, required: false
        argument :scope, Types::Arguments::Order::OrderScopes, required: true
        argument :query, String, required: false

        def resolve(**args)
          # TODO: Search to be implemented
          paginate(queried, 'orders')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def queried
          ::Order.where(restaurant_owner_id: context[:current_user]).send(arguments[:scope]).order(sort_hash)
        end

        def sort_hash
          @sort_hash ||= { "#{arguments[:order_by] || 'id'}": arguments[:order_direction] || 'asc' }
        end
      end
    end
  end
end