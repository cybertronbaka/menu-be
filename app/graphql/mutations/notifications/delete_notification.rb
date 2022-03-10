# frozen_string_literal: true

module Mutations
  module Notifications
    class DeleteNotification < BaseMutation
      argument :id, ID, required: true

      type Types::Custom::Notification

      def resolve(**args)
        Resolvers::Mutations::Notifications::DeleteNotification.new(context, arguments).run
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
