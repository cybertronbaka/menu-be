FactoryBot.define do
  factory :order do
    mobile { nil }
    table_no { 1 }
    restaurant_owner { nil }

    trait :pending do
      status { 'pending' }
    end

    trait :served do
      status { 'served' }
    end

    trait :paid do
      status { 'paid' }
    end

    trait :cancelled do
      status { 'cancelled' }
    end

    before :create do |order|
      order.order_items << create(:order_item, order: order, item: Item.first)
    end
  end
end
