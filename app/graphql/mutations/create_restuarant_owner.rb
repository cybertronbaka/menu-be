#frozen_string_literal: true

module Mutations
  class CreateRestuarantOwner < BaseMutation
    # arguments passed to the `resolve` method
    argument :user_creation_attributes, Types::Arguments::UserCreationAttributes, required: true
    argument :profile_attributes, Types::Arguments::ProfileAttributes, required: true

    # return type from the mutation
    type Types::Custom::User

    def resolve(user_creation_attributes: nil, profile_attributes: nil)
      Resolvers::Mutations::CreateRestuarantOwner.new(context, arguments).run
    end

    def ready?(**args)
      user_required && authorized
    end

    def is_authorized?
      is_super_admin?
    end
  end
end
  