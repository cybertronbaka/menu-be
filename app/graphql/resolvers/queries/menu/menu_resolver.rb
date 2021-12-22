# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenuResolver < BaseQueryResolver
        type Types::Custom::Menu, null: false

        argument :id, ID, required: true

        def resolve(id: nil)
          raise Unauthorized unless owner?

          menu
        end

        def ready?(**_args)
          user_required && authorized
        end

        def is_authorized?
          is_restuarant_owner?
        end

        private

        def menu
          @menu ||= ::Menu.find(arguments[:id].to_i)
        end

        def owner?
          context[:current_user].id == menu.user_id
        end
      end
    end
  end
end
