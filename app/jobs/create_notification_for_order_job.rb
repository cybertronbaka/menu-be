class CreateNotificationForOrderJob < ApplicationJob
  queue_as :default

  # def perform(order)
  def perform(order)
    notification = Notification.create!(
      notification_type: 'food_orders',
      body: "You have received an order of Nu.#{order.total} from #{order.mobile}",
      link: "/order-details/#{order.link}"
    )
    ActionCable.server.broadcast "notifications_channel_#{order.user_id}", notification.as_json
  end
end
