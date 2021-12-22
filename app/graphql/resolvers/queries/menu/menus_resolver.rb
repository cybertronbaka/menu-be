# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenusResolver < BaseQueryResolver
        type [Types::Custom::Menu], null: false

        def resolve(**args)
          ::Menu.where(user_id: context[:current_user].id)
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
