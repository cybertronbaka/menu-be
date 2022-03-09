# frozen_string_literal: true

module Mutations
  module Notifications
    class MarkAllAsRead < BaseMutation
      type Types::Custom::DefaultResponse

      def resolve(**args)
        Resolvers::Mutations::Notifications::MarkAllAsRead.new(context, arguments).run
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
