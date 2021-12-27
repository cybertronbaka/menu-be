class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :mobile
      t.integer :status, null: false, default: 0
      t.float :total, null: false, default: 0
      t.integer :table_no, null: false
      t.belongs_to :restaurant_owner
      t.timestamps
    end
  end
end
