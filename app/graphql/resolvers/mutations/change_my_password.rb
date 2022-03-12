# frozen_string_literal: true

module Resolvers
  module Mutations
    class ChangeMyPassword < BaseMutationResolver
      def run
        raise Unauthorized unless user.valid_password?(params[:current_password])

        raise StandardError, 'Password and Password Confirmation need to be same' if password_not_same?

        user.password = params[:password]
        user.password_confirmation = params[:password_confirmation]
        user.save!
        user
      end

      private

      def user
        @user ||= context[:current_user]
      end

      def password_not_same?
        params[:password] != params[:password_confirmation]
      end
    end
  end
end
