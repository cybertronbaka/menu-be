# frozen_string_literal: true

module Resolvers
  module Mutations
    class EditUser < BaseMutationResolver
      delegate :profile, to: :user

      def run
        user && update_user && update_profile
        user
      end

      private

      def update_user
        return true unless params[:user_attributes]

        user.update!(params[:user_attributes].as_json)
      end

      def update_profile
        return true unless params[:profile_attributes]

        profile.update!(params[:profile_attributes].as_json)
      end

      def user
        @user ||= User.find(params[:id])
      end
    end
  end
end
