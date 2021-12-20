module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_restuarant_owner, mutation: Mutations::CreateRestuarantOwner
    field :edit_user, mutation: Mutations::EditUser
  end
end
