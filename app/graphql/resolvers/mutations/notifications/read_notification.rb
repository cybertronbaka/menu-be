# frozen_string_literal: true

module Resolvers
  module Mutations
    module Notifications
      class ReadNotification < BaseMutationResolver
        def run
          raise Unauthorized unless owner?

          notification.update!(read: true)
          notification.reload
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
