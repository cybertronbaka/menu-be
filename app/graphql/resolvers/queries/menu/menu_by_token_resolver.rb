# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenuByTokenResolver < BaseQueryResolver
        type Types::Custom::Menu, null: false

        argument :token, String, required: true

        def resolve(token: nil)
          raise StandardError, 'Your Subscription has been Cancelled! Please contact us to resolve this.' if cancelled?

          menu
        end

        def menu
          @menu ||= ::Menu.find_by!(token: arguments[:token].to_s)
        end

        def cancelled?
          menu.user.cancelled?
        end
      end
    end
  end
end
