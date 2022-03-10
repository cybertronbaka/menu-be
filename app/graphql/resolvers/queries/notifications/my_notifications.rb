# frozen_string_literal: true

module Resolvers
  module Queries
    module Notifications
      class MyNotifications < BaseQueryResolver
        include GqlPagination

        type Types::Custom::NotificationList, null: false

        def resolve(**args)
          paginate(queried, 'notifications')
        end

        def ready?(**_args)
          user_required
        end

        def queried
          ::Notification.where(user_id: context[:current_user].id).order(created_at: :desc)
        end
      end
    end
  end
end
