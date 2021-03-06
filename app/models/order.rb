# frozen_string_literal: true

class Order < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :query, against: %i[mobile table_no], using: {
    trigram: {
      threshold: 0.3,
      word_similarity: true
    },
    tsearch: {
      any_word: true
    }
  }

  validates_presence_of :table_no, :total, :status
  validates :order_items, length: { minimum: 1 }

  enum status: { pending: 0, served: 1, paid: 2, cancelled: 3 }

  belongs_to :restaurant_owner, class_name: 'User', foreign_key: :restaurant_owner_id, primary_key: :id
  has_many :order_items, dependent: :destroy

  before_create :calculate_total
  after_create :send_notification

  def calculate_total
    self.total = order_items.inject(0) do |sum, order_item|
      sum + order_item.item.price * order_item.quantity
    end
  end

  def send_notification
    CreateNotificationForOrderJob.perform_later(self)
  end

  accepts_nested_attributes_for :order_items
end