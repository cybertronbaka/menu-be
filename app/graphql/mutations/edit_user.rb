#frozen_string_literal: true

module Mutations
  class EditUser < BaseMutation
    # arguments passed to the `resolve` method
    argument :id, ID, required: true
    argument :user_attributes, Types::Arguments::UserEditAttributes, required: false
    argument :profile_attributes, Types::Arguments::ProfileAttributes, required: false
    argument :menu_allowed, Integer, required: false

    # return type from the mutation
    type Types::Custom::User

    def resolve(id: nil, user_attributes: nil, profile_attributes: nil, menu_allowed: nil)
      Resolvers::Mutations::EditUser.new(context, arguments).run
    end

    def ready?(**args)
      user_required && authorized
    end

    def is_authorized?
      is_super_admin? || context[:current_user].id == arguments[:id]
    end
  end
end
  