module Types
  class MutationType < Types::BaseObject
    field :create_restuarant_owner, mutation: Mutations::CreateRestuarantOwner
    field :edit_user, mutation: Mutations::EditUser

    # Menu
    field :create_menu, mutation: Mutations::Menu::CreateMenu
    field :edit_menu, mutation: Mutations::Menu::EditMenu
    field :delete_menu, mutation: Mutations::Menu::DeleteMenu

    # Section
    field :create_section, mutation: Mutations::Section::CreateSection
    field :edit_section, mutation: Mutations::Section::EditSection
    field :delete_section, mutation: Mutations::Section::DeleteSection

    # Item
    field :create_item, mutation: Mutations::Item::CreateItem
    field :edit_item, mutation: Mutations::Item::EditItem
    field :delete_item, mutation: Mutations::Item::DeleteItem

    # Table
    field :create_table, mutation: Mutations::Table::CreateTable
  end
end
