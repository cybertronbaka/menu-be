# frozen_string_literal: true

module Resolvers
  module Mutations
    class CreateRestuarantOwner < BaseMutationResolver
      def run
        user && profile
        user
      end

      private

      def user
        @user ||= User.create!(**params[:user_creation_attributes].as_json, role_id: 2)
      end

      def profile
        @profile ||= Profile.create!(**params[:profile_attributes].as_json, user: user)
      end
    end
  end
end
