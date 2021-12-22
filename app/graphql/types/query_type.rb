module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # User
    field :users, resolver: Resolvers::Queries::UsersResolver

    # Menu
    field :my_menus, resolver: Resolvers::Queries::Menu::MenusResolver
    field :menu, resolver: Resolvers::Queries::Menu::MenuResolver

    # Section
    field :sections, resolver: Resolvers::Queries::Section::SectionsResolver
    field :section, resolver: Resolvers::Queries::Section::SectionResolver

    # Items
    field :items, resolver: Resolvers::Queries::Item::ItemsResolver
    field :item, resolver: Resolvers::Queries::Item::ItemResolver
  end
end
