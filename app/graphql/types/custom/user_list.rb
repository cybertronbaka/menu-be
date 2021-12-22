# frozen_string_literal: true

module Types
  module Custom
    class UserList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :users, [Types::Custom::User], null: true
    end
  end
end
