# frozen_string_literal: true

class Notification < ApplicationRecord
  include BroadcastHelper

  enum notification_type: { food_orders: 0 }

  belongs_to :user

  def broadcast
    ActionCable.server.broadcast "notifications_channel_#{user_id}", to_gql_json
  end
end