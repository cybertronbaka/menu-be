module Types
  class MutationType < Types::BaseObject
    field :create_restuarant_owner, mutation: Mutations::CreateRestuarantOwner
    field :edit_user, mutation: Mutations::EditUser
    field :create_menu, mutation: Mutations::Menu::CreateMenu
  end
end
