# frozen_string_literal: true

module Mutations
  class ChangeMyPassword < BaseMutation
    # arguments passed to the `resolve` method
    argument :current_password, String,required: true, description: 'Current Password of the User'
    argument :password,String, required: true
    argument :password_confirmation,String, required: true

    # return type from the mutation
    type Types::Custom::User

    def resolve(**args)
      Resolvers::Mutations::ChangeMyPassword.new(context, arguments).run
    end

    def ready?(**_args)
      user_required
    end
  end
end
