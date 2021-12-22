# frozen_string_literal: true

module Types
  module Custom
    class MenuList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :menus, [Types::Custom::Menu], null: true
    end
  end
end
