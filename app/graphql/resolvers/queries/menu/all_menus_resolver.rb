# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class AllMenusResolver < BaseQueryResolver
        include GqlPagination

        argument :order_by, Types::Arguments::Menu::MenuSortBy, required: false
        argument :order_direction, Types::Arguments::OrderDirection, required: false
        argument :query, String, required: false

        type Types::Custom::MenuList, null: false

        def resolve(**args)
          paginate(queried, 'menus')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_super_admin?
        end

        def queried
          arguments[:query].blank? ? sorted_menus : sorted_menus.query(arguments[:query])
        end

        def sorted_menus
          ::Menu.all.order(sort_hash)
        end

        def sort_hash
          @sort_hash ||= { "#{arguments[:order_by] || 'id'}": arguments[:order_direction] || 'asc' }
        end
      end
    end
  end
end
