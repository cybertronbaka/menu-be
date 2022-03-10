# frozen_string_literal: true

module Types
  module Custom
    class Notification < BaseObject
      field :id, ID, null: false
      field :notification_type, String, null: false
      field :body, String, null: false
      field :link, String, null: false
      field :image, String, null: true
      field :read, Boolean, null: false
      field :user_id, ID, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
