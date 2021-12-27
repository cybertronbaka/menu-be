class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :item
      t.integer :quantity, null: false, default: 1
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
