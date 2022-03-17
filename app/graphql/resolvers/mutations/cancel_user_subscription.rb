# frozen_string_literal: true

module Resolvers
  module Mutations
    class CancelUserSubscription < BaseMutationResolver
      def run
        user.update!(status: :cancelled)
        user.invalidate_all_sessions!
        user.reload
      end

      private

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
