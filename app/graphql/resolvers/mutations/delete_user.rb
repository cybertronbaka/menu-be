# frozen_string_literal: true

module Resolvers
  module Mutations
    class DeleteUser < BaseMutationResolver
      def run
        user.destroy!
        user
      end

      private

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
