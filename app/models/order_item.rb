# frozen_string_literal: true

class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :status

  enum status: { pending: 0, served: 1 }

  belongs_to :order
  belongs_to :item
end