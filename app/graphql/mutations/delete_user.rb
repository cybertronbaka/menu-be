# frozen_string_literal: true

module Mutations
  class DeleteUser < BaseMutation
    # arguments passed to the `resolve` method
    argument :id, ID, required: true

    # return type from the mutation
    type Types::Custom::User

    def resolve(**args)
      Resolvers::Mutations::DeleteUser.new(context, arguments).run
    end

    def ready?(**_args)
      user_required && authorized
    end

    def is_authorized?
      is_super_admin?
    end
  end
end
