# frozen_string_literal: true

class PurchaseNeededError < StandardError
  def initialize(msg = 'To create more menu, please contact us')
    super
  end

  def code
    'PURCHASE_NEEDED'
  end
end
