module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def user_required
      return (raise Unauthenticated) unless context[:current_user]
      
      true
    end

    def authorized
      return ( raise Unauthorized ) unless is_authorized?

      true
    end

    def is_super_admin?
      context[:current_user]&.super_admin?
    end

    def is_restuarant_owner?
      context[:current_user]&.restuarant_owner?
    end
  end
end
