module Types
  class MutationType < Types::BaseObject
    field :create_restuarant_owner, mutation: Mutations::CreateRestuarantOwner
    field :edit_user, mutation: Mutations::EditUser
    field :delete_user, mutation: Mutations::DeleteUser

    # Menu
    field :create_menu, mutation: Mutations::Menu::CreateMenu
    field :edit_menu, mutation: Mutations::Menu::EditMenu
    field :delete_menu, mutation: Mutations::Menu::DeleteMenu

    # Section
    field :create_section, mutation: Mutations::Section::CreateSection
    field :edit_section, mutation: Mutations::Section::EditSection
    field :delete_section, mutation: Mutations::Section::DeleteSection
    field :reorder_sections, mutation: Mutations::Section::ReorderSections

    # Item
    field :create_item, mutation: Mutations::Item::CreateItem
    field :edit_item, mutation: Mutations::Item::EditItem
    field :delete_item, mutation: Mutations::Item::DeleteItem
    field :reorder_items, mutation: Mutations::Item::ReorderItems

    # Table
    # field :create_table, mutation: Mutations::Table::CreateTable
    # field :delete_table, mutation: Mutations::Table::DeleteTable

    # Order
    field :create_order, mutation: Mutations::Order::CreateOrder
    field :edit_order, mutation: Mutations::Order::EditOrder
    field :delete_order, mutation: Mutations::Order::DeleteOrder

    # Order Item
    field :edit_order_item, mutation: Mutations::OrderItem::EditOrderItem
    field :delete_order_item, mutation: Mutations::OrderItem::DeleteOrderItem

    # Notification
    field :read_notification, mutation: Mutations::Notifications::ReadNotification
  end
end
