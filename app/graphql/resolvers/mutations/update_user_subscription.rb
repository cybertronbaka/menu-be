# frozen_string_literal: true

module Resolvers
  module Mutations
    class UpdateUserSubscription < BaseMutationResolver
      def run
        user.update!(status: params[:status])
        user.invalidate_all_sessions! if params[:status].to_sym == :cancelled
        user.reload
      end

      private

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
