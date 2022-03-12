# frozen_string_literal: true

class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :status

  enum status: { pending: 0, served: 1 }

  before_create :update_fields

  def update_fields
    self.name = item.name
    self.description = item.description
    self.price = item.price
    self.pictures = item.pictures
  end

  belongs_to :order
  belongs_to :item, optional: true
end