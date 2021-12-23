# frozen_string_literal: true

module Resolvers
  module Queries
    module Menu
      class MenuByTokenResolver < BaseQueryResolver
        type Types::Custom::Menu, null: false

        argument :token, String, required: true

        def resolve(token: nil)
          ::Table.find_by!(token: arguments[:token].to_s).menu
        end
      end
    end
  end
end
