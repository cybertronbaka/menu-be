# frozen_string_literal: true

module Types
  module Custom
    class NotificationList < BaseObject
      field :page_info, Types::Custom::PageInfo, null: true
      field :notifications, [Types::Custom::Notification], null: true
    end
  end
end
