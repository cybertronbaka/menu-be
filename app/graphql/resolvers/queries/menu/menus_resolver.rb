# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenusResolver < BaseQueryResolver
        include GqlPagination

        type Types::Custom::MenuList, null: false

        def resolve(**args)
          paginate(::Menu.where(user_id: context[:current_user].id), 'menus')
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
end
