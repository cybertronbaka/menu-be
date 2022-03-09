# frozen_string_literal: true

class Notification < ApplicationRecord
  enum notification_type: { food_orders: 0 }

  belongs_to :user

  def broadcast
    ActionCable.server.broadcast "notifications_channel_#{user_id}", as_json
  end
end