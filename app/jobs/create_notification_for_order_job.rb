class CreateNotificationForOrderJob < ApplicationJob
  queue_as :default

  # def perform(order)
  def perform(order)
    notification = Notification.create!(
      notification_type: 'food_orders',
      body: "You have received an order of Nu.#{order.total} from #{order.mobile}",
      link: "/order-details/#{order.id}"
    )
    ActionCable.server.broadcast "notifications_channel_#{order.restaurant_owner_id}", notification.as_json
  end
end
