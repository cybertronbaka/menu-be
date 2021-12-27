# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenuByTokenResolver < BaseQueryResolver
        type Types::Custom::Menu, null: false

        argument :token, String, required: true

        def resolve(token: nil)
          ::Menu.find_by!(token: arguments[:token].to_s)
        end
      end
    end
  end
end
