class SendOrderThroughWsJob < ApplicationJob
  queue_as :default

  # def perform(order)
  def perform(order)
    order.broadcast
  end
end
