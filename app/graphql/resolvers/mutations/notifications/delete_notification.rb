# frozen_string_literal: true

module Resolvers
  module Mutations
    module Notifications
      class DeleteNotification < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          notification.destroy!
          notification
        end

        private

        def notification
          @notification ||= ::Notification.find(params[:id].to_i)
        end

        def owner?
          context[:current_user].id == notification.user_id
        end
      end
    end
  end
end
