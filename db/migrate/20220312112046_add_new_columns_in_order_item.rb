class AddNewColumnsInOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :name, :string
    add_column :order_items, :description, :string
    add_column :order_items, :price, :float
    add_column :order_items, :pictures, :string, array: true, default: []
  end
end
