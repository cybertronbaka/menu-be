# frozen_string_literal: true

class Notification < ApplicationRecord
  enum notification_type: { food_orders: 0 }

  # after_create :broadcast
end