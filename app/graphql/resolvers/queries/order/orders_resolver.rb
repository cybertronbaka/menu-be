module Resolvers
  module Queries
    module Order
      class OrdersResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::OrderList, null: true

        argument :order_by, Types::Arguments::Order::OrdersSortBy, required: false
        argument :order_direction, Types::Arguments::OrderDirection, required: false
        argument :scope, Types::Arguments::Order::OrderScopes, required: true
        argument :start_date, String, required: false
        argument :end_date, String, required: false
        argument :query, String, required: false

        def resolve(**args)
          # TODO: Search to be implemented
          {
            **paginate(queried, 'orders'),
            total_today: sorted_orders.where(created_at: Date.today.all_day).sum(&:total)
          }
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def queried
          arguments[:query].blank? ? date_filtered : date_filtered.query(arguments[:query])
        end

        def date_filtered
          return sorted_orders unless arguments[:start_date] && arguments[:end_date]

          sorted_orders.where(created_at: arguments[:start_date]..arguments[:end_date])
        end

        def sorted_orders
          ::Order.where(restaurant_owner_id: context[:current_user]).send(arguments[:scope]).order(sort_hash)
        end

        def sort_hash
          @sort_hash ||= { "#{arguments[:order_by] || 'created_at'}": arguments[:order_direction] || 'desc' }
        end
      end
    end
  end
end
