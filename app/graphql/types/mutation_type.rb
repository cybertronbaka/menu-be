module Types
  class MutationType < Types::BaseObject
    field :create_restuarant_owner, mutation: Mutations::CreateRestuarantOwner
    field :edit_user, mutation: Mutations::EditUser

    #Menu
    field :create_menu, mutation: Mutations::Menu::CreateMenu

    # Section
    field :create_section, mutation: Mutations::Section::CreateSection
    field :edit_section, mutation: Mutations::Section::EditSection
    field :delete_section, mutation: Mutations::Section::DeleteSection
  end
end
