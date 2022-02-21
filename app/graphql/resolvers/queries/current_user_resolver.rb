# frozen_string_literal: true

module Resolvers
  module Queries
    class CurrentUserResolver < BaseQueryResolver
      type Types::Custom::User, null: false

      def resolve
        context[:current_user]
      end

      def ready?(**_args)
        user_required
      end
    end
  end
end
