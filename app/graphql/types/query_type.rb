module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # User
    field :users, resolver: Resolvers::Queries::UsersResolver
    field :current_user, resolver: Resolvers::Queries::CurrentUserResolver

    # Menu
    field :my_menus, resolver: Resolvers::Queries::Menu::MenusResolver
    field :menu, resolver: Resolvers::Queries::Menu::MenuResolver
    field :menu_by_token, resolver: Resolvers::Queries::Menu::MenuByTokenResolver
    field :all_menus, resolver: Resolvers::Queries::Menu::AllMenusResolver

    # Section
    field :sections, resolver: Resolvers::Queries::Section::SectionsResolver
    field :section, resolver: Resolvers::Queries::Section::SectionResolver

    # Items
    field :items, resolver: Resolvers::Queries::Item::ItemsResolver
    field :item, resolver: Resolvers::Queries::Item::ItemResolver

    # Table
    # field :tables, resolver: Resolvers::Queries::Table::TablesResolver
    # field :table, resolver: Resolvers::Queries::Table::TableResolver

    # Order
    field :orders, resolver: Resolvers::Queries::Order::OrdersResolver
    field :order, resolver: Resolvers::Queries::Order::OrderResolver

    # OrderItem
    field :order_items, resolver: Resolvers::Queries::OrderItem::OrderItemsResolver
    field :order_item, resolver: Resolvers::Queries::OrderItem::OrderItemResolver

    # Notification
    field :my_notifications, resolver: Resolvers::Queries::Notifications::MyNotifications
  end
end
