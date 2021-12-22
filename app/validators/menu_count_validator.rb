# frozen_string_literal: true

class MenuCountValidator < ActiveModel::Validator
  attr_accessor :record

  delegate :user, to: :record

  def validate(record)
    @record = record

    raise_error if user.menus.count >= restriction

    true
  end

  private

  def restriction
    Restriction.find_by(restriction_type: 'menu_count', user_id: user.id)&.value&.to_i || 1
  end

  def raise_error
    raise PurchaseNeededError
  end
end
