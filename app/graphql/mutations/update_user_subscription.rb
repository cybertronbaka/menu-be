# frozen_string_literal: true

module Mutations
  class UpdateUserSubscription < BaseMutation
    # arguments passed to the `resolve` method
    argument :id, ID, required: true
    argument :status, String, required: true

    # return type from the mutation
    type Types::Custom::User

    def resolve(**args)
      Resolvers::Mutations::UpdateUserSubscription.new(context, arguments).run
    end

    def ready?(**_args)
      user_required && authorized
    end

    def is_authorized?
      is_super_admin?
    end
  end
end
