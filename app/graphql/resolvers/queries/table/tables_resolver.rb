# frozen_string_literal: true

module Resolvers
  module Queries
    module Table
      class TablesResolver < BaseQueryResolver
        include GqlPagination
        type Types::Custom::TableList, null: false

        argument :menu_id, ID, required: true

        def resolve(menu_id: nil)
          raise Unauthorized unless owner?

          paginate(::Table.where(menu: menu_id), 'tables')
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def menu
          @menu ||= ::Menu.find(arguments[:menu_id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
