# frozen_string_literal: true

module Resolvers
  module Mutations
    module SuperAdmin
      class ChangeUserPassword < BaseMutationResolver
        def run
          raise Unauthorized unless context[:current_user].valid_password?(params[:current_password])

          raise StandardError, 'Password and Password Confirmation need to be same' if password_not_same?

          user.password = params[:password]
          user.password_confirmation = params[:password_confirmation]
          user.save!
          user
        end

        private

        def user
          @user ||= User.find(params[:id])
        end

        def password_not_same?
          params[:password] != params[:password_confirmation]
        end
      end
    end
  end
end
