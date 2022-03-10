# frozen_string_literal: true

module Resolvers
  module Mutations
    module Notifications
      class MarkAllAsRead < BaseMutationResolver
        def run
          notifications.update_all(read: true)
          { success: true }
        end

        private

        def notifications
          @notifications ||= ::Notification.where(user_id: context[:current_user].id, read: false)
        end
      end
    end
  end
end
