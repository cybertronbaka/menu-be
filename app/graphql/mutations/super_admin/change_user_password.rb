# frozen_string_literal: true

module Mutations
  module SuperAdmin
    class ChangeUserPassword < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, ID, required: true
      argument :current_password, String, required: true, description: 'Current Password of the Super Admin'
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      # return type from the mutation
      type Types::Custom::User

      def resolve(**args)
        Resolvers::Mutations::SuperAdmin::ChangeUserPassword.new(context, arguments).run
      end

      def ready?(**_args)
        user_required && authorized
      end

      def is_authorized?
        is_super_admin?
      end
    end
  end
end
